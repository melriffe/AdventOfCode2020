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
    busses.sort.first.waiting_time
  end

  def exercise2
    0
  end

  private

  attr_accessor :departure_time, :busses

  def parse_data
    self.busses = []
    data.each_with_index do |line, index|
      self.departure_time = line.to_i if index.zero?
      if index.positive?
        bus_ids = line.split(',')
        bus_ids.delete('x')
        bus_ids.each do |id|
          busses << Bus.new( id.to_i, departure_time )
        end
      end
    end
  end
end

class Bus
  include Comparable

  def initialize id, target_departure_time
    self.id = id
    self.target_departure_time = target_departure_time
  end

  def <=>(other)
    earliest_departure_time <=> other.earliest_departure_time
  end

  def earliest_departure_time
    @earliest_departure_time ||= calculate_earliest_departure_time
  end

  def waiting_time
    @waiting_time ||= calculature_waiting_time
  end

  private

  attr_accessor :id, :target_departure_time

  def calculate_earliest_departure_time
    minutes = id
    while(minutes < target_departure_time)
      minutes += id
    end
    minutes
  end

  def calculature_waiting_time
    id * (earliest_departure_time - target_departure_time)
  end

end
