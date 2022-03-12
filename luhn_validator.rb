# frozen_string_literal: true

# Implementation of the Luhn algorithm
module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.chars.map(&:to_i).reverse

    # TODO: use the integers in nums_a to validate its last check digit
    check = nums_a
            .each_with_index
            .reduce(0) do |a, (d, i)|
      a + get_val(d, i)
    end

    (check % 10).zero?
  end

  def get_val(digit, index)
    (digit * (index.odd? ? 2 : 1)).digits.sum
  end
end
