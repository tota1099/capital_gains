require_relative './transactions/calculate_tax'

class Transaction
  attr_accessor :quantity, :unit_cost, :operation

  def initialize(quantity:, unit_cost:, operation:)
    @quantity = quantity
    @unit_cost = unit_cost
    @operation = operation
  end

  def buy?
    @operation == 'buy'
  end

  def price
    @quantity * @unit_cost
  end

  def add_quantity(quantity)
    @quantity += quantity
  end

  def remove_quantity(quantity)
    @quantity -= quantity
  end
end