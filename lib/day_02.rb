##
# --- Day 2: Password Philosophy ---
# https://adventofcode.com/2020/day/2
#
class Day02
  attr_accessor :data

  ##
  # The expected format of the incoming data is:
  #   Array[<String>]
  #
  # String has the format of: 'm-n x: password'
  # Example: '1-3 a: abcde'
  #
  def initialize data
    self.data = data
  end

  ##
  # According to the specified rules + passwords (i.e. 'data') return
  # the number of 'valid' passwords.
  #
  # The policy specified is in the form of:
  #  m-n x: where 'm' is the minimum count, 'n' is the maximum count,
  #         and 'x' is the target letter
  #
  # Therefore, each specified password must have a count of the specified
  # letter a minimum of 'm' and a maximum  of 'n' times.
  #
  def exercise1
    parse_data
    validators.select { |validator| validator.valid? }.size
  end

  private

  attr_accessor :validators

  def parse_data
    self.validators = []

    data.each do |line|
      parts = line.split(':')
      validators << PasswordValidator.new(parts.first, parts.last)
    end
  end
end

class PasswordValidator
  attr_accessor :password, :policy

  def initialize policy, password
    self.policy = policy
    self.password = password
    parse_policy
  end

  ##
  # A 'password' is valid if it contains 'letter' from 'min' to 'max' times.
  #
  def valid?
    letter_count = password.count letter
    return letter_count <= max && letter_count >= min
  end

  private

  attr_accessor :letter, :max, :min

  ##
  # 'policy' is expected to be in the form of: 'm-n x'
  #
  def parse_policy
    parts = policy.split(' ')
    self.letter = parts.last
    parts = parts.first.split('-')
    self.min = parts.first.to_i
    self.max = parts.last.to_i
  end
end
