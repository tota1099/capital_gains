require 'json'
require './models/wallet'
require './models/transaction'
require './models/taxes/calculator'

class CapitalGainsJson
  class << self
    def calculate_taxes(transactions)
      transactions = JSON.parse(transactions)
      transactions = transactions.map do |transaction|
        Transaction.new(
          quantity: transaction["quantity"],
          unit_cost: transaction["unit-cost"],
          operation: transaction["operation"],
        )
      end
      Taxes::Calculator.call(transactions:)
    end
  end
end
