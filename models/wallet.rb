require_relative './wallets/add_transaction'

class Wallet
  attr_accessor :quantity, :weighted_price, :loss_amount

  def initialize
    @quantity = 0
    @weighted_price = 0.0
    @loss_amount = 0.0
  end

  def price
    @quantity * @weighted_price
  end

  def process_buy(transaction)
    @weighted_price = (price + transaction.price) / (quantity + transaction.quantity)
    @quantity += transaction.quantity
  end

  def process_sell(transaction)
    @quantity -= transaction.quantity
  end

  def has_loss?
    @loss_amount > 0.0
  end

  def add_loss(transaction)
    @loss_amount += (@weighted_price - transaction.unit_cost) * transaction.quantity
  end

  def discount_loss(gain)
    @loss_amount -= gain
  end

  def reset_loss
    @loss_amount = 0.0
  end
end