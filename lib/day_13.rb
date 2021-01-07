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
    big_bus = busses.max_by { |bus| bus.number }
    time = -big_bus.delta
    increment = big_bus.number
    loop do
      time += increment
      checks = busses.collect { |bus| bus.departure_time? time }
      break if checks.all?
    end
    time
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

  def <=>(other)
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
