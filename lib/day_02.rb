# frozen_string_literal: true

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
    parse_data MinMaxValidator
    validators.count(&:valid?)
  end

  ##
  # According to the specified rules + passwords (i.e. 'data') return
  # the number of 'valid' passwords.
  #
  # The policy specified is in the form of:
  #  m-n x: where 'm' is a position, 'n' is another position, and 'x'
  #         is the target letter
  #
  # Therefore, each specified password must have the specified letter
  # in exactly one of the specified positions.
  #
  def exercise2
    parse_data PositionalValidator
    validators.count(&:valid?)
  end

  private

  attr_accessor :validators

  def parse_data klass
    self.validators = []

    data.each do |line|
      parts = line.split(':')
      validators << klass.new(parts.first.strip, parts.last.strip)
    end
  end
end

class MinMaxValidator
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
    letter_count <= max && letter_count >= min
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

class PositionalValidator
  attr_accessor :password, :policy

  def initialize policy, password
    self.policy = policy
    self.password = password
    parse_policy
  end

  ##
  # A 'password' is valid if 'letter' is in exactly one position.
  #
  def valid?
    a = password[position1] == letter ? 1 : 0
    b = password[position2] == letter ? 1 : 0
    (a + b) == 1
  end

  private

  attr_accessor :letter, :position1, :position2

  ##
  # 'policy' is expected to be in the form of: 'm-n x'
  #
  def parse_policy
    parts = policy.split(' ')
    self.letter = parts.last
    parts = parts.first.split('-')
    self.position1 = parts.first.to_i - 1
    self.position2 = parts.last.to_i - 1
  end
end
