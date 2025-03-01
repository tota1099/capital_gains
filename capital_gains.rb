require 'json'

class CapitalGains
  def call(transactions)
    transactions = JSON.parse(transactions)

    wallet = transactions.reduce({
      amount: 0,
      price_average: 0.0,
      loss_amount: 0.0,
      taxes: []
    }) do |wallet, transaction|
      if transaction["operation"] == "buy"
        wallet[:price_average] = weighted_average(wallet, transaction)
        wallet[:amount] += transaction["quantity"]
        wallet[:taxes] << 0.0
      else
        wallet[:amount] -= transaction["quantity"]

        if transaction["unit-cost"] < wallet[:price_average]
          wallet[:taxes] << 0.0
          wallet[:loss_amount] += (wallet[:price_average] - transaction["unit-cost"]) * transaction["quantity"]
        elsif transaction["unit-cost"] > wallet[:price_average] && (transaction["quantity"] * transaction["unit-cost"]) > 20000
          gain = (transaction["unit-cost"] - wallet[:price_average]) * transaction["quantity"]
          if wallet[:loss_amount] > 0.0
            if gain <= wallet[:loss_amount]
              wallet[:loss_amount] -= gain
              wallet[:taxes] << 0.0
            else
              gain -= wallet[:loss_amount]
              wallet[:loss_amount] = 0.0
              wallet[:taxes] << gain * 0.2
            end
          else
            wallet[:taxes] << gain * 0.2
          end
        else
          wallet[:taxes] << 0.0
        end
      end
      wallet
    end

    wallet[:taxes].map { |tax| { tax: } }
  end

  def weighted_average(wallet, transaction)
    wallet_price = wallet[:amount] * wallet[:price_average]
    transaction_price = transaction["quantity"] * transaction["unit-cost"]

    (wallet_price + transaction_price) / (wallet[:amount] + transaction["quantity"])
  end
end
