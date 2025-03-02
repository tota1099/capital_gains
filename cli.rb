require './capital_gains_json'

outputs = []
while (input = gets.chomp) != ''
  outputs << CapitalGainsJson.calculate_taxes(input)
end

outputs.each { |ouput| p ouput }