##
# --- Day 3: Toboggan Trajectory ---
# https://adventofcode.com/2020/day/3
#
class Day03
  attr_accessor :data

  ##
  # The expected format of the incoming data is:
  #   Array[<String>]
  #
  # String has the format of: '..##.......'
  # A '.' represents open space. A '#' represents a tree
  # The collection of strings represents a map.
  #
  def initialize data
    self.data = data
  end

  ##
  # According to the specified map (i.e. 'data'), count the number of
  # trees (i.e. '#') the toboggan will encounter when it travels in a
  # slope of 'right 3 down 1'.
  #
  # NOTE: "These aren't the only trees, though; due to something you
  # read about once involving arboreal genetics and biome stability,
  # the same pattern repeats to the right many times"
  #
  def exercise1 slope = Slope.new(right: 3, down: 1)
    last_row = data.length - 1
    return 0 if last_row.zero?

    trees_encountered = 0

    # Slope of Travel
    right = slope.right
    down = slope.down

    current_col = current_row = 0
    edge = data.first.length

    while current_row <= last_row

      line = data[current_row]
      space = line[current_col]

      trees_encountered += 1 if space == '#'

      if (current_col + right) >= edge
        current_col = (current_col + right) - edge
      else
        current_col += right
      end
      current_row += down

    end

    trees_encountered
  end

  ##
  # Time to check several slopes and return the product of their values
  #
  def exercise2
    slope = Slope.new
    value = exercise1 slope

    slope = Slope.new right: 3
    value *= exercise1 slope

    slope = Slope.new right: 5
    value *= exercise1 slope

    slope = Slope.new right: 7
    value *= exercise1 slope

    slope = Slope.new right: 1, down: 2
    value *= exercise1 slope

    value
  end
end

class Slope
  attr_accessor :down, :right

  def initialize right: 1, down: 1
    self.right = right
    self.down = down
  end
end
