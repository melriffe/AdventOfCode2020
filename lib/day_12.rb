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
    parse_data
    ship = WaypointShip.new navigation_instructions
    ship.sail!
    ship.manhattan_distance
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

  def update navigation
    navigation.forward value
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

  def update navigation
    navigation.rotate_left steps
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

  def update navigation
    navigation.rotate_right steps
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

class Location
  attr_reader :east_units, :west_units, :north_units, :south_units

  def initialize
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

  def manhattan_distance
    horizontal_distance + vertical_distance
  end

  private

  attr_writer :east_units, :north_units, :south_units, :west_units

  def horizontal_distance
    (east_units - west_units).abs
  end

  def vertical_distance
    (north_units - south_units).abs
  end
end

class Navigation
  extend Forwardable

  # Indices      [   0    1    2    3    ]
  DIRECTIONS = %i[ east south west north ]

  attr_accessor :location

  def initialize key = 0
    self.location = Location.new
    self.key = key
  end

  def apply command
    if navigation_command? command
      command.update self
    else
      location.update command
    end
  end

  ##
  # NOTE: Nasty Hack because of AoC.
  #
  def navigation_command? command
    %w[ ForwardMovement LeftRotation RightRotation ].include? command.class.name
  end

  def direction
    DIRECTIONS[key]
  end

  # ForwardMovement API
  def forward value
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

  # LeftRotation API
  def rotate_left steps
    self.turn_left steps
  end

  # east -> north -> west -> south -> east
  def turn_left steps
    value = key - steps
    value = (4 + value).abs if value.negative?
    self.key = value
  end

  # RightRotation API
  def rotate_right steps
    self.turn_right steps
  end

  # east -> south -> west -> north -> east
  def turn_right steps
    value = key + steps
    value = (4 - value).abs if value >= 4
    self.key = value
  end

  delegate %i[manhattan_distance] => :location

  private

  attr_accessor :key
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

class Ship
  extend Forwardable

  def initialize navigation_instructions
    self.navigation_instructions = navigation_instructions
    build_ship
  end

  def sail!
    navigation_instructions.each do |instruction|
      command = Captain.parse instruction
      engine.perform command
    end
  end

  delegate %i[manhattan_distance] => :navigation

  protected

  def build_ship
    self.navigation = Navigation.new
    self.engine = Engine.new navigation
  end

  private

  attr_accessor :engine, :navigation, :navigation_instructions
end

class Waypoint
  extend Forwardable

  attr_reader :location

  def initialize
    initialize_waypoint_location
  end

  def update command
    command.update self
  end

  def east value
    location.east value
    location_changed!
  end

  def west value
    location.west value
    location_changed!
  end

  def north value
    location.north value
    location_changed!
  end

  def south value
    location.south value
    location_changed!
  end

  # LeftRotation API
  def rotate_left steps
    self.location = Location.new
    case steps
    when 1 # location_left
      location_left.each do |direction, value|
        location.send(direction.to_sym, value)
      end
    when 2 # location_opposite
      location_opposite.each do |direction, value|
        location.send(direction.to_sym, value)
      end
    when 3 # location_right
      location_right.each do |direction, value|
        location.send(direction.to_sym, value)
      end
    else
      raise 'Ka-Blam!'
    end
    location_changed!
  end

  # RightRotation API
  def rotate_right steps
    self.location = Location.new
    case steps
    when 1 # location_right
      location_right.each do |direction, value|
        location.send(direction.to_sym, value)
      end
    when 2 # location_opposite
      location_opposite.each do |direction, value|
        location.send(direction.to_sym, value)
      end
    when 3 # location_left
      location_left.each do |direction, value|
        location.send(direction.to_sym, value)
      end
    else
      raise 'Ka-Blam!'
    end
    location_changed!
  end

  delegate %i[east_units west_units north_units south_units] => :location

  private

  attr_accessor :location_opposite, :location_right, :location_left
  attr_writer :location

  def initialize_waypoint_location
    self.location = Location.new
    location.east 10
    location.north 1
    location_changed!
  end

  ##
  # Derive from this waypoint's location, its opposite location and its
  # left & right locations. These will be determined to make 'rotation'
  # easier.
  #
  # Example: For a location east 10, north 1
  #   oppositie location is: west 10, south 1
  #   right location is:     east 1, south 10
  #   left location is:      west 1, north 10.
  #
  def location_changed!
    east = location.east_units
    west = location.west_units

    north = location.north_units
    south = location.south_units

    # NOTE: expectation is 1 of the paired directions will be zero.
    calculate_location_opposite east: east, west: west, north: north, south: south
    calculate_location_right east: east, west: west, north: north, south: south
    calculate_location_left
  end

  # Example: For a location east 10, north 1
  #   oppositie location is: west 10, south 1
  #
  def calculate_location_opposite east:, west:, north:, south:
    self.location_opposite = {}
    if east.zero?
      location_opposite[:east] = west
    else
      location_opposite[:west] = east
    end

    if north.zero?
      location_opposite[:north] = south
    else
      location_opposite[:south] = north
    end
  end

  # Example: For a location east 10, north 1
  #   right location is:     east 1, south 10
  #
  def calculate_location_right east:, west:, north:, south:
    self.location_right = {}
    if east.zero? && north.zero?
      location_right[:west] = south
      location_right[:north] = west
    elsif east.zero? && south.zero?
      location_right[:east] = north
      location_right[:north] = west
    elsif west.zero? && north.zero?
      location_right[:west] = south
      location_right[:south] = east
    else
      location_right[:east] = north
      location_right[:south] = east
    end
  end

  # Example: For a location east 10, north 1
  #   left location is:      west 1, north 10.
  #
  # NOTE: location left is opposite from location right
  def calculate_location_left
    self.location_left = {}
    if location_right.key? :east
      location_left[:west] = location_right[:east]
    else
      location_left[:east] = location_right[:west]
    end

    if location_right.key? :north
      location_left[:south] = location_right[:north]
    else
      location_left[:north] = location_right[:south]
    end
  end
end

class WaypointNavigation
  extend Forwardable

  def initialize
    self.waypoint = Waypoint.new
    self.location = Location.new
  end

  def apply command
    if navigation_command? command
      command.update self
    else
      waypoint.update command
    end
  end

  ##
  # NOTE: Nasty Hack because of AoC.
  #
  def navigation_command? command
    %w[ ForwardMovement ].include? command.class.name
  end

  # ForwardMovement API
  def forward value
    east = waypoint.east_units
    west = waypoint.west_units

    north = waypoint.north_units
    south = waypoint.south_units

    # NOTE: expectation is 1 of the paired directions will be zero.
    if east.zero?
      value.times { location.west west }
    else
      value.times { location.east east }
    end

    if north.zero?
      value.times { location.south south }
    else
      value.times { location.north north }
    end
  end

  delegate %i[manhattan_distance] => :location

  private

  attr_accessor :location, :waypoint
end

class WaypointShip < Ship
  protected

  def build_ship
    self.navigation = WaypointNavigation.new
    self.engine = Engine.new navigation
  end
end
