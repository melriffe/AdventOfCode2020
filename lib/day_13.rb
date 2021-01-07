# frozen_string_literal: true
##
# --- Day 13: Shuttle Search ---
# https://adventofcode.com/2020/day/13
#
class Day13
  attr_accessor :data

  ##
  # 'data' is an Array[<String>], where "String" is a series of characters
  # representing a navigational command.
  #
  # The set represents navigation instructions.
  #
  def initialize data
    self.data = data
  end

  def exercise1
    parse_data
    busses.min.waiting_time
  end

  def exercise2
    parse_data
    # NOTE: Thanks to https://github.com/KrzaQ/AdventOfCode2020/blob/main/solutions/day13/main.rb
    # for showing me what values needed to be in my arrays.
    mods, rems = busses.map { |bus| [bus.number, (bus.number - bus.delta) % bus.number] }.transpose
    HubeiProvince.new(mods, rems).chinese_remainder
  end

  private

  attr_accessor :departure_time, :busses

  def parse_data
    self.busses = []
    data.each_with_index do |line, index|
      self.departure_time = line.to_i if index.zero?
      next unless index.positive?

      bus_ids = line.split(',')
      bus_ids.each_with_index do |id, index2|
        next if id == 'x'

        busses << Bus.new(id.to_i, departure_time, index2)
      end
    end
  end
end

class Bus
  include Comparable

  attr_reader :delta

  def initialize id, target_departure_time, delta = 0
    self.id = id
    self.target_departure_time = target_departure_time
    self.delta = delta
  end

  def number
    id
  end

  def <=> other
    earliest_departure_time <=> other.earliest_departure_time
  end

  def departure_time? target_time
    ((target_time + delta) % id).zero?
  end

  def earliest_departure_time
    @earliest_departure_time ||= calculate_earliest_departure_time
  end

  def waiting_time
    @waiting_time ||= calculature_waiting_time
  end

  private

  attr_accessor :id, :target_departure_time
  attr_writer :delta

  def calculate_earliest_departure_time
    minutes = id
    minutes += id while minutes < target_departure_time
    minutes
  end

  def calculature_waiting_time
    id * (earliest_departure_time - target_departure_time)
  end
end

##
# Implements the Chinese Remainder Theorem, shamelessly copied from
# https://rosettacode.org/wiki/Chinese_remainder_theorem#Ruby
#
# https://en.wikipedia.org/wiki/Hubei whose capital is Wuhan
#
class HubeiProvince

  def initialize mods, remainders
    self.mods = mods
    self.remainders = remainders
  end

  def chinese_remainder
    max = mods.inject(:* ) # product of all moduli
    series = remainders.zip(mods).map{ |r,m| (r * max * invmod(max/m, m) / m) }
    series.inject( :+ ) % max
  end

  private

  attr_accessor :mods, :remainders

  def invmod(e, et)
    g, x = extended_gcd(e, et)
    if g != 1
      raise 'Multiplicative inverse modulo does not exist!'
    end
    x % et
  end

  def extended_gcd(a, b)
    last_remainder, remainder = a.abs, b.abs
    x, last_x = 0, 1
    while remainder != 0
      last_remainder, (quotient, remainder) = remainder, last_remainder.divmod(remainder)
      x, last_x = last_x - quotient*x, x
    end
    return last_remainder, last_x * (a < 0 ? -1 : 1)
  end
end
