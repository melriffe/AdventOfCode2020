# frozen_string_literal: true
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
    AdapterAnalyzer.joltage_differences adapters.sort
  end

  def exercise2
    parse_data
    AdapterAnalyzer.distinct_arrangements adapters.sort
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

class AdapterAnalyzer
  def self.joltage_differences adapters
    ones = 0
    threes = 1

    jotlage_rating = 0

    adapters.sort.each do |rating|
      case rating - jotlage_rating
      when 1
        ones += 1
      when 3
        threes += 1
      end
      jotlage_rating = rating
    end

    ones * threes
  end

  def self.distinct_arrangements adapters
    count adapters, from: 0, start_at: 0, memo: []
  end

  def self.count adapters, from:, start_at:, memo:
    count = 0
    size = adapters.length - 1

    return 1 if size < start_at
    return memo[start_at] unless memo[start_at].nil?

    if from + 3 >= adapters[start_at]
      count += self.count adapters, from: adapters[start_at], start_at: start_at + 1, memo: memo
    end

    if size >= start_at + 1 && (from + 3 >= adapters[start_at + 1])
      count += self.count adapters, from: adapters[start_at + 1], start_at: start_at + 2, memo: memo
    end

    if size >= start_at + 2 && (from + 3 >= adapters[start_at + 2])
      count += self.count adapters, from: adapters[start_at + 2], start_at: start_at + 3, memo: memo
    end

    memo[start_at] = count
    count
  end
end
