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
    parse_data
    messages.count do |l|
      regexp.match l
    end
  end

  def exercise2
    0
  end

  private

  attr_accessor :rules, :messages, :regexp

  def parse_data
    self.rules = {}
    blank_line = data.index ''
    data.slice!(0..blank_line).each do |line|
      next if line.chomp.strip.length.zero?

      rule_parts = line.strip.split(': ')
      rules[rule_parts.first.to_i] = rule_parts.last
    end

    self.messages = []
    data.each do |line|
      next if line.chomp.strip.length.zero?

      messages << line.strip
    end

    self.regexp = RegexpGenerator.new(rules).generate!
  end
end

class RegexpGenerator
  def initialize rules
    self.rules = rules
    self.rules_to_translate = rules.to_a
    self.tr_rules = {}
  end

  def generate!
    loop do
      populate_rule_numbers
      translate_rule_numbers
      update_progress

      break if rules_to_translate.empty?
    end

    new_regexp
  end

  private

  attr_accessor :rules, :tr_rules, :rules_to_translate, :rule_numbers

  ##
  # Get a batch of rule numbers that need to be translated, that is
  # turned into a regular expressions.
  #
  # This is done by iterating over the rules that need to be translated
  # and picking those that haven't already been translated. This means
  # the rule numbers are not in the 'tr_rules' structure.
  #
  # Because we're iterating over 2-element arrays, we only want the
  # first element of each member of the numbers array.
  #
  def populate_rule_numbers
    numbers = rules_to_translate.select do |_number, rule|
      rule.scan(/\d+/).map(&:to_i) - tr_rules.keys == []
    end.map(&:first)

    self.rule_numbers = numbers
  end

  ##
  # This is where the magic happens. This is were we take a rule number
  # and convert it into a regular expression and store it in the 'tr_rules'
  # structure.
  #
  def translate_rule_numbers
    rule_numbers.each do |num|
      tr_rules[num] = "(?:#{translate(num)})"
    end
  end

  ##
  # More magic. This is actually the source of the magic. If a rule is a
  # letter, we return it. If a rule contains numbers, we return it but
  # using the values we've already translated. The way the rules are
  # processed, we're guaranteed to translate the 'letter' rules first.
  # This lets us build the regular expressions of the other rules as a
  # function of the lettered rules already translated.
  #
  # The '_1' is populated by the digits captured in the initial gsub.
  # This is used to lookup translated rules, supplying the value to the
  # next gsub, whose return value is then returned to the method caller.
  #
  # For example: '4 4 | 5 5' is translated to: '(?:a)(?:a)|(?:b)(?:b)'
  # That value is stored under rule number 2, for the test data rules.
  #
  def translate rule_number
    rules[rule_number].gsub(/\d+/){ tr_rules[_1.to_i] }.gsub(/[ "]/, '')
  end

  ##
  # Remove from 'rules_to_translate' rules that have been translated.
  #
  def update_progress
    self.rules_to_translate = rules_to_translate.reject { |number, _| rule_numbers.include? number }
  end

  def new_regexp
    Regexp.new rule_zero_pattern
  end

  def rule_zero_pattern
    "^#{tr_rules[0]}$"
  end
end
