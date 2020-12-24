##
# --- Day 10: Adapter Array ---
# https://adventofcode.com/2020/day/10
#
class Day10
  attr_accessor :data

  ##
  # 'data' is an Array[<String>], where "String" is a digit. It represents
  # different joltage adapters.
  #
  def initialize data
    self.data = data
  end

  def exercise1
    parse_data

    one_jolt_differences = 0
    three_jolt_differences = 1

    jotlage_rating = 0

    adapters.sort.each do |rating|
      case rating - jotlage_rating
      when 1
        one_jolt_differences += 1
      when 2
        # NOOP
      when 3
        three_jolt_differences += 1
      else
        # NOOP
      end
      jotlage_rating = rating
    end

    one_jolt_differences * three_jolt_differences
  end

  def exercise2
    parse_data
    0
  end

  private

  attr_accessor :adapters

  def parse_data
    self.adapters = data.collect do |line|
      next if line.chomp.strip.length.zero?
      line.to_i
    end
  end
end