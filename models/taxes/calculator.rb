module Taxes
  class Calculator
    class << self
      def call(transactions:)
        wallet = Wallet.new
        taxes = transactions.map do |transaction|
          Wallets::AddTransaction.call(wallet:, transaction:)
          Transactions::CalculateTax.call(wallet:, transaction:)
        end

        taxes.map { |tax| { tax: } }
      end
    end
  end
end