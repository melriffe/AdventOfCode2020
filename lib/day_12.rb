require 'forwardable'

##
# --- Day 12: Rain Risk ---
# https://adventofcode.com/2020/day/12
#
class Day12
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
    ship = Ship.new navigation_instructions
    ship.sail!
    ship.manhattan_distance
  end

  def exercise2
    0
  end

  private

  attr_accessor :navigation_instructions

  def parse_data
    self.navigation_instructions = []
    data.each do |line|
      next if line.chomp.strip.length.zero?
      navigation_instructions << line
    end
  end
end

class NorthMovement
  attr_accessor :value

  def initialize value
    self.value = value
  end

  def update location
    location.north value
  end
end

class SouthMovement
  attr_accessor :value

  def initialize value
    self.value = value
  end

  def update location
    location.south value
  end
end

class EastMovement
  attr_accessor :value

  def initialize value
    self.value = value
  end

  def update location
    location.east value
  end
end

class WestMovement
  attr_accessor :value

  def initialize value
    self.value = value
  end

  def update location
    location.west value
  end
end

class ForwardMovement
  attr_accessor :value

  def initialize value
    self.value = value
  end

  def update location
    location.forward value
  end
end

class LeftRotation
  attr_accessor :value

  def initialize value
    self.value = value
  end

  def steps
    value / 90
  end

  def update location
    location.rotate_left steps
  end
end

class RightRotation
  attr_accessor :value

  def initialize value
    self.value = value
  end

  def steps
    value / 90
  end

  def update location
    location.rotate_right steps
  end
end

class Captain
  ACTIONS = {
    'N' => NorthMovement,
    'S' => SouthMovement,
    'E' => EastMovement,
    'W' => WestMovement,
    'L' => LeftRotation,
    'R' => RightRotation,
    'F' => ForwardMovement
  }

  def self.parse instruction
    action = instruction[0]
    value = instruction[1..-1]

    ACTIONS[action].new value.to_i
  end
end

class Facing
  # Indices      [   0    1    2    3    ]
  DIRECTIONS = %i[ east south west north ]

  def initialize key = 0
    self.key = key
  end

  def direction
    DIRECTIONS[key]
  end

  def update location, value
    case direction
    when :east
      location.east value
    when :south
      location.south value
    when :west
      location.west value
    when :north
      location.north value
    else
      # NOOP
    end
  end

  # east -> north -> west -> south -> east
  def turn_left steps
    value = key - steps
    value = (4 + value).abs if value.negative?
    self.key = value
  end

  # east -> south -> west -> north -> east
  def turn_right steps
    value = key + steps
    value = (4 - value).abs if value >= 4
    self.key = value
  end

  private

  attr_accessor :key

end

class Location
  attr_reader :east_units, :west_units, :north_units, :south_units

  def initialize facing
    self.facing = facing
    self.east_units = 0
    self.west_units = 0
    self.north_units = 0
    self.south_units = 0
  end

  def update command
    command.update self
  end

  def east value
    if west_units.zero?
      self.east_units += value
    else
      self.west_units -= value
      if west_units.negative?
        self.east_units = west_units.abs
        self.west_units = 0
      end
    end
  end

  def west value
    if east_units.zero?
      self.west_units += value
    else
      self.east_units -= value
      if east_units.negative?
        self.west_units = east_units.abs
        self.east_units = 0
      end
    end
  end

  def north value
    if south_units.zero?
      self.north_units += value
    else
      self.south_units -= value
      if south_units.negative?
        self.north_units = south_units.abs
        self.south_units = 0
      end
    end
  end

  def south value
    if north_units.zero?
      self.south_units += value
    else
      self.north_units -= value
      if north_units.negative?
        self.south_units = north_units.abs
        self.north_units = 0
      end
    end
  end

  def forward value
    facing.update self, value
  end

  def rotate_left steps
    facing.turn_left steps
  end

  def rotate_right steps
    facing.turn_right steps
  end

  def manhattan_distance
    horizontal_distance + vertical_distance
  end

  private

  attr_accessor :facing
  attr_writer :east_units, :north_units, :south_units, :west_units

  def horizontal_distance
    (east_units - west_units).abs
  end

  def vertical_distance
    (north_units - south_units).abs
  end

end

class Engine
  attr_accessor :navigation

  def initialize navigation
    self.navigation = navigation
  end

  def perform command
    navigation.apply command
  end
end

class Navigation
  attr_accessor :location

  def initialize location
    self.location = location
  end

  def apply command
    location.update command
  end
end

class Ship
  extend Forwardable

  def initialize navigation_instructions
    self.facing = Facing.new

    self.location = Location.new facing
    self.navigation = Navigation.new location
    self.engine = Engine.new navigation

    self.navigation_instructions = navigation_instructions
  end

  def sail!
    navigation_instructions.each do |instruction|
      command = Captain.parse instruction
      engine.perform command
    end
  end

  delegate %i[manhattan_distance] => :location

  private

  attr_accessor :engine, :facing, :location, :navigation, :navigation_instructions

end