require 'json'

class CapitalGains
  TAX_RATE = 0.2
  EXEMPTION_LIMIT = 20000

  def call(transactions = [])
    transactions = JSON.parse(transactions, symbolize_names: true)
    calculate_taxes(transactions)
  end

  private

  def calculate_taxes(transactions)
    wallet = { amount: 0, price_average: 0.0, loss_amount: 0.0, taxes: [] }
    transactions.each do |transaction|
      wallet = process_transaction(wallet, transaction)
    end

    wallet[:taxes].map { |tax| { tax: tax } }
  end

  def process_transaction(wallet, transaction)
    if buy?(transaction)
      wallet[:price_average] = weighted_average(wallet, transaction)
      wallet[:amount] += transaction[:quantity]
      add_tax(wallet, 0.0)
    else
      wallet[:amount] -= transaction[:quantity]
      tax = calculate_tax_for_sale(wallet, transaction)
      add_tax(wallet, tax)
    end
    wallet
  end

  def calculate_tax_for_sale(wallet, transaction)
    if is_sale_at_loss?(wallet, transaction)
      wallet[:loss_amount] += (wallet[:price_average] - transaction[:'unit-cost']) * transaction[:quantity]
      0.0
    elsif is_sale_at_gain?(wallet, transaction) && need_tax?(transaction)
      gain = calculate_gain(wallet, transaction)
      if wallet_has_loss(wallet)
        calculate_tax_with_loss(wallet, gain)
      else
        gain * TAX_RATE
      end
    else
      0.0
    end
  end

  def weighted_average(wallet, transaction)
    wallet_price = wallet[:amount] * wallet[:price_average]

    (wallet_price + transaction_price(transaction)) / (wallet[:amount] + transaction[:quantity])
  end

  def calculate_tax_with_loss(wallet, gain)
    if gain <= wallet[:loss_amount]
      wallet[:loss_amount] -= gain
      0.0
    else
      remaining_gain = gain - wallet[:loss_amount]
      wallet[:loss_amount] = 0.0
      remaining_gain * TAX_RATE
    end
  end

  def buy?(transaction)
    transaction[:operation] == "buy"
  end

  def is_sale_at_loss?(wallet, transaction)
    transaction[:'unit-cost'] < wallet[:price_average]
  end

  def is_sale_at_gain?(wallet, transaction)
    transaction[:'unit-cost'] > wallet[:price_average]
  end

  def need_tax?(transaction)
    transaction_price(transaction) > EXEMPTION_LIMIT
  end

  def transaction_price(transaction)
    transaction[:quantity] * transaction[:'unit-cost']
  end

  def wallet_has_loss(wallet)
    wallet[:loss_amount] > 0.0
  end

  def calculate_gain(wallet, transaction)
    (transaction[:'unit-cost'] - wallet[:price_average]) * transaction[:quantity]
  end

  def add_tax(wallet, tax)
    wallet[:taxes] << tax
  end
end
