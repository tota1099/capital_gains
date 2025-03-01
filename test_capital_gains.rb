require "minitest/autorun"
require "./capital_gains"

class TestCapitalGains < Minitest::Test
  def setup
    @capital_gains = CapitalGains.new
  end

  def test_case_1
    inputs = File.read('inputs/case1.txt')
    expected = [
      [{"tax": 0.00},{"tax": 0.00},{"tax": 0.00}]
    ]
    inputs.each_line.with_index do |input, index|
      assert_equal @capital_gains.call(input), expected[index]
    end
  end

  def test_case_2
    inputs = File.read('inputs/case2.txt')
    expected = [
      [{"tax": 0.00},{"tax": 10000.00},{"tax": 0.00}]
    ]
    inputs.each_line.with_index do |input, index|
      assert_equal @capital_gains.call(input), expected[index]
    end
  end

  def test_case_1_plus_2
    inputs = File.read('inputs/case1+2.txt')
    expected = [
      [{"tax": 0.00},{"tax": 0.00},{"tax": 0.00}],
      [{"tax": 0.00},{"tax": 10000.00},{"tax": 0.00}]
    ]

    inputs.each_line.with_index do |input, index|
      assert_equal @capital_gains.call(input), expected[index]
    end
  end

  def test_case_3
    inputs = File.read('inputs/case3.txt')
    expected = [
      [{"tax": 0.00},{"tax": 0.00},{"tax": 1000.00}]
    ]

    inputs.each_line.with_index do |input, index|
      assert_equal @capital_gains.call(input), expected[index]
    end
  end

  def test_case_4
    inputs = File.read('inputs/case4.txt')
    expected = [
      [{"tax": 0.00},{"tax": 0.00},{"tax": 0.00}]
    ]

    inputs.each_line.with_index do |input, index|
      assert_equal @capital_gains.call(input), expected[index]
    end
  end

  def test_case_5
    inputs = File.read('inputs/case5.txt')
    expected = [
      [{"tax": 0.00},{"tax": 0.00},{"tax": 0.00},{"tax": 10000.00}]
    ]

    inputs.each_line.with_index do |input, index|
      assert_equal @capital_gains.call(input), expected[index]
    end
  end

  def test_case_6
    inputs = File.read('inputs/case6.txt')
    expected = [
      [{"tax": 0.00},{"tax": 0.00},{"tax": 0.00},{"tax": 0.00},{"tax": 3000.00}]
    ]

    inputs.each_line.with_index do |input, index|
      assert_equal @capital_gains.call(input), expected[index]
    end
  end

  def test_case_7
    inputs = File.read('inputs/case7.txt')
    expected = [
      [{"tax":0.00}, {"tax":0.00}, {"tax":0.00}, {"tax":0.00}, {"tax":3000.00}, {"tax":0.00}, {"tax":0.00}, {"tax":3700.00}, {"tax":0.00}]
    ]

    inputs.each_line.with_index do |input, index|
      assert_equal @capital_gains.call(input), expected[index]
    end
  end

  def test_case_8
    inputs = File.read('inputs/case8.txt')
    expected = [
      [{"tax":0.00},{"tax":80000.00},{"tax":0.00},{"tax":60000.00}]
    ]

    inputs.each_line.with_index do |input, index|
      assert_equal @capital_gains.call(input), expected[index]
    end
  end
end