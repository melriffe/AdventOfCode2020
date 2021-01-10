# frozen_string_literal: true

##
# --- Day 19: Monster Messages ---
# https://adventofcode.com/2020/day/19
#
class Day19
  attr_accessor :data

  ##
  # 'data' is an Array[<String>]. The set of data represents a set of
  # rules and a set of messages that may or may not match Rule 0. The
  # two groups of data are separated by a blank line.
  #
  # The whole message must match all of rule 0; there can't be extra
  # unmatched characters in the message.
  #
  def initialize data
    self.data = data
  end

  def exercise1
    0
  end

  def exercise2
    0
  end

  private

  attr_accessor :rules, :messages

  def parse_data
    # Parse the rules for valid messages:
    self.rules = []
    rules_separator = data.index ''
    rules_for_valid_messages = data.slice!(0..rules_separator)
    rules_for_valid_messages.each do |line|
      next if line.chomp.strip.length.zero?

      rules << line
    end

    rules.sort!

    # Parse the messages recevied:
    self.messages = []
    data.each do |line|
      next if line.chomp.strip.length.zero?

      messages << line
    end
  end
end

##
# By virture of how the rules are defined, Rules 0 defines multiple
# valid combinations. The rules for valid messages are numbered and
# build upon each other.
#
# Some rules simply match a single character. Some rules list the
# sub-rules that must be followed. Some of the rules have multiple
# lists of sub-rules separated by a pipe (|). This means that at
# least one list of sub-rules must match. The list of possible
# matches will be finite.
#
class Rule

end
