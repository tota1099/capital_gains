require "minitest/autorun"
require "./capital_gains_json"

class TestCapitalGains < Minitest::Test
  def setup
    @capital_gains = CapitalGainsJson
  end

  def inputs(name)
    File.read("./tests/inputs/#{name}.txt")
  end

  def test_case_1
    expected = [
      [{"tax": 0.00},{"tax": 0.00},{"tax": 0.00}]
    ]
    inputs('case1').each_line.with_index do |input, index|
      assert_equal @capital_gains.calculate_taxes(input), expected[index]
    end
  end

  def test_case_2
    expected = [
      [{"tax": 0.00},{"tax": 10000.00},{"tax": 0.00}]
    ]
    inputs('case2').each_line.with_index do |input, index|
      assert_equal @capital_gains.calculate_taxes(input), expected[index]
    end
  end

  def test_case_1_plus_2
    expected = [
      [{"tax": 0.00},{"tax": 0.00},{"tax": 0.00}],
      [{"tax": 0.00},{"tax": 10000.00},{"tax": 0.00}]
    ]

    inputs('case1+2').each_line.with_index do |input, index|
      assert_equal @capital_gains.calculate_taxes(input), expected[index]
    end
  end

  def test_case_3
    expected = [
      [{"tax": 0.00},{"tax": 0.00},{"tax": 1000.00}]
    ]

    inputs('case3').each_line.with_index do |input, index|
      assert_equal @capital_gains.calculate_taxes(input), expected[index]
    end
  end

  def test_case_4
    expected = [
      [{"tax": 0.00},{"tax": 0.00},{"tax": 0.00}]
    ]

    inputs('case4').each_line.with_index do |input, index|
      assert_equal @capital_gains.calculate_taxes(input), expected[index]
    end
  end

  def test_case_5
    expected = [
      [{"tax": 0.00},{"tax": 0.00},{"tax": 0.00},{"tax": 10000.00}]
    ]

    inputs('case5').each_line.with_index do |input, index|
      assert_equal @capital_gains.calculate_taxes(input), expected[index]
    end
  end

  def test_case_6
    expected = [
      [{"tax": 0.00},{"tax": 0.00},{"tax": 0.00},{"tax": 0.00},{"tax": 3000.00}]
    ]

    inputs('case6').each_line.with_index do |input, index|
      assert_equal @capital_gains.calculate_taxes(input), expected[index]
    end
  end

  def test_case_7
    expected = [
      [{"tax":0.00}, {"tax":0.00}, {"tax":0.00}, {"tax":0.00}, {"tax":3000.00}, {"tax":0.00}, {"tax":0.00}, {"tax":3700.00}, {"tax":0.00}]
    ]

    inputs('case7').each_line.with_index do |input, index|
      assert_equal @capital_gains.calculate_taxes(input), expected[index]
    end
  end

  def test_case_8
    expected = [
      [{"tax":0.00},{"tax":80000.00},{"tax":0.00},{"tax":60000.00}]
    ]

    inputs('case8').each_line.with_index do |input, index|
      assert_equal @capital_gains.calculate_taxes(input), expected[index]
    end
  end
end