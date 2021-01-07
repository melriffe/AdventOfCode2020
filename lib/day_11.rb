require 'forwardable'
require 'singleton'
require 'observer'

##
# --- Day 11: Seating System ---
# https://adventofcode.com/2020/day/11
#
class Day11
  attr_accessor :data

  ##
  # 'data' is an Array[<String>], where "String" is a series of characters
  # representing a seating layout.
  #
  def initialize data
    self.data = data
  end

  def exercise1
    parse_data
    SeatLayoutTransitionLogic.instance.adjacent_logic!
    until seat_layout.no_seat_changes?
      seat_layout.analyze
      seat_layout.transition
    end
    seat_layout.occupied_seats
  end

  def exercise2
    parse_data
    SeatLayoutTransitionLogic.instance.first_seat_logic!
    until seat_layout.no_seat_changes?
      seat_layout.analyze
      seat_layout.transition
    end
    seat_layout.occupied_seats
  end

  private

  attr_accessor :seat_layout

  def parse_data
    self.seat_layout = SeatLayout.from data
  end
end

class PositionalLimits
  @@max_col = 0
  @@max_row = 0

  def self.max_col
    @@max_col
  end

  def self.max_col= value
    raise ArgumentError, "'value' must be a postive whole number" if value < 1

    @@max_col = value
  end

  def self.max_row
    @@max_row
  end

  def self.max_row= value
    raise ArgumentError, "'value' must be a postive whole number" if value < 1

    @@max_row = value
  end

  def self.left column
    column.zero? ? -1 : column - 1
  end

  def self.right column
    column == PositionalLimits.max_col ? PositionalLimits.max_col + 1 : column + 1
  end

  def self.up row
    row.zero? ? -1 : row - 1
  end

  def self.down row
    row == PositionalLimits.max_row ? PositionalLimits.max_row + 1 : row + 1
  end
end

class Position
  attr_reader :column, :row

  def initialize column, row
    self.column = column
    self.row    = row
  end

  def eql? other_position
    column == other_position.column && row == other_position.row
  end

  def hash
    (Math::PI * column.hash) + row.hash
  end

  def upper_left
    Position.new(PositionalLimits.up(column), PositionalLimits.left(row))
  end

  def up
    Position.new(PositionalLimits.up(column), row)
  end

  def upper_right
    Position.new(PositionalLimits.up(column), PositionalLimits.right(row))
  end

  def left
    Position.new(column, PositionalLimits.left(row))
  end

  def right
    Position.new(column, PositionalLimits.right(row))
  end

  def lower_left
    Position.new(PositionalLimits.down(column), PositionalLimits.left(row))
  end

  def down
    Position.new(PositionalLimits.down(column), row)
  end

  def lower_right
    Position.new(PositionalLimits.down(column), PositionalLimits.right(row))
  end

  private

  attr_writer :column, :row
end

class EmptyState
  def empty?
    true
  end

  def occupied?
    false
  end

  def transition_logic
    SeatLayoutTransitionLogic.instance.transition_logic self
  end

  def next_state
    OccupiedState
  end
end

class OccupiedState
  def empty?
    false
  end

  def occupied?
    true
  end

  def transition_logic
    SeatLayoutTransitionLogic.instance.transition_logic self
  end

  def next_state
    EmptyState
  end
end

class AdjacentEmptyToOccupiedState
  ##
  # If a seat is empty (L) and there are no occupied seats adjacent
  # to it, the seat becomes occupied. Otherwise, the seat's state
  # does not change.
  #
  def self.should_transition? my_position, seat_layout
    occupants = seat_layout.occupants_adjacent_to my_position
    occupants.select { |occupant| occupant.occupied? }.empty?
  end
end

class AdjacentOccupiedToEmptyState
  ##
  # If a seat is occupied (#) and four or more seats adjacent to it
  # are also occupied, the seat becomes empty. Otherwise, the seat's
  # state does not change.
  #
  def self.should_transition? my_position, seat_layout
    occupants = seat_layout.occupants_adjacent_to my_position
    occupants.select { |occupant| occupant.occupied? }.size > 3
  end
end

class FirstSeatEmptyToOccupiedState
  ##
  # If a seat is empty (L) and it sees no other occupied seats around
  # it, the seat becomes occupied. Otherwise, the seat's state does
  # not change. Only the first seat seen is considered.
  #
  # Line of sight is in the 8 directions from the given seat, until the
  # edge of the grid is met.
  #
  def self.should_transition? my_position, seat_layout
    occupants = seat_layout.occupants_visible_from my_position
    occupants.select { |occupant| occupant.occupied? }.empty?
  end
end

class FirstSeatOccupiedToEmptyState
  ##
  # If a seat is occupied (#) and it sees five or more occupied seats
  # around it, the seat becomes empty. Otherwise, the seat's state
  # does not change. Only the first seat seen is considered.
  #
  # Line of sight is in the 8 directions from the given seat, until the
  # edge of the grid is met.
  #
  def self.should_transition? my_position, seat_layout
    occupants = seat_layout.occupants_visible_from my_position
    occupants.select { |occupant| occupant.occupied? }.size > 4
  end
end

class Seat
  extend Forwardable
  include Observable

  def initialize
    self.state = EmptyState.new
  end

  def seat?
    true
  end

  def prepare_next_transition my_position, seat_layout
    if state.transition_logic.should_transition? my_position, seat_layout
      self.next_state = state.next_state.new
    end
  end

  def transition
    if self.next_state && self.state != self.next_state
      changed
      self.state = next_state
      self.next_state = nil
      notify_observers(self)
    end
  end

  delegate %i[empty? occupied?] => :state

  private

  attr_accessor :next_state, :state
end

class Floor
  extend Forwardable

  def initialize
    self.state = EmptyState.new
  end

  def seat?
    false
  end

  def prepare_next_transition my_position, seat_layout
    # NOOP
  end

  def transition
    # NOOP
  end

  delegate %i[empty? occupied?] => :state

  private

  attr_accessor :state
end

class SeatLayout
  attr_reader :positions

  def self.from data
    new data
  end

  def initialize data
    self.positions     = {}
    self.changed_seats = []
    self.running       = false

    parse_data data
  end

  def occupant_at position
    positions[position]
  end

  def occupants_adjacent_to position
    adjacent_occupants = []
    adjacent_occupants << self.occupant_at(position.left)
    adjacent_occupants << self.occupant_at(position.upper_left)
    adjacent_occupants << self.occupant_at(position.up)
    adjacent_occupants << self.occupant_at(position.upper_right)
    adjacent_occupants << self.occupant_at(position.right)
    adjacent_occupants << self.occupant_at(position.lower_right)
    adjacent_occupants << self.occupant_at(position.down)
    adjacent_occupants << self.occupant_at(position.lower_left)
    adjacent_occupants.compact
  end

  def occupants_visible_from position
    visible_occupants = []
    visible_occupants << self.first_seat_left(position.left)
    visible_occupants << self.first_seat_upper_left(position.upper_left)
    visible_occupants << self.first_seat_up(position.up)
    visible_occupants << self.first_seat_upper_right(position.upper_right)
    visible_occupants << self.first_seat_right(position.right)
    visible_occupants << self.first_seat_lower_right(position.lower_right)
    visible_occupants << self.first_seat_down(position.down)
    visible_occupants << self.first_seat_lower_left(position.lower_left)
    visible_occupants.compact
  end

  def first_seat_left position
    occupant = self.occupant_at position
    return occupant if occupant.nil? || occupant.seat?

    first_seat_left position.left
  end

  def first_seat_upper_left position
    occupant = self.occupant_at position
    return occupant if occupant.nil? || occupant.seat?

    first_seat_upper_left position.upper_left
  end

  def first_seat_up position
    occupant = self.occupant_at position
    return occupant if occupant.nil? || occupant.seat?

    first_seat_up position.up
  end

  def first_seat_upper_right position
    occupant = self.occupant_at position
    return occupant if occupant.nil? || occupant.seat?

    first_seat_upper_right position.upper_right
  end

  def first_seat_right position
    occupant = self.occupant_at position
    return occupant if occupant.nil? || occupant.seat?

    first_seat_right position.right
  end

  def first_seat_lower_right position
    occupant = self.occupant_at position
    return occupant if occupant.nil? || occupant.seat?

    first_seat_lower_right position.lower_right
  end

  def first_seat_down position
    occupant = self.occupant_at position
    return occupant if occupant.nil? || occupant.seat?

    first_seat_down position.down
  end

  def first_seat_lower_left position
    occupant = self.occupant_at position
    return occupant if occupant.nil? || occupant.seat?

    first_seat_lower_left position.lower_left
  end

  def update changed_seat
    changed_seats << changed_seat
  end

  def no_seat_changes?
    running? && changed_seats.empty?
  end

  def analyze
    running!
    positions.each do |position, occupant|
      occupant.prepare_next_transition position, self
    end
  end

  def transition
    changed_seats.clear
    positions.each do |position, occupant|
      occupant.transition
    end
  end

  def occupied_seats
    positions.values.select { |occupant| occupant.occupied? }.size
  end

  private

  attr_accessor :changed_seats, :running
  attr_writer :positions

  def parse_data seat_layout
    column = row = 0
    seat_layout.each do |line|
      next if line.chomp.strip.length.zero?

      row = 0
      line.each_char do |character|
        case character
        when '.'
          occupant = Floor.new
        when 'L'
          occupant = Seat.new
          occupant.add_observer(self)
        else
          # NOOP
        end

        position = Position.new column, row
        positions[position] = occupant
        row += 1
      end
      column += 1
    end

    PositionalLimits.max_col = column - 1
    PositionalLimits.max_row = row - 1

    self
  end

  def running!
    self.running = true unless running?
  end

  def running?
    running
  end
end

class SeatLayoutTransitionLogic
  include Singleton

  def initialize
    self.strategies = {
      adjacent: {
        true => AdjacentEmptyToOccupiedState,
        false => AdjacentOccupiedToEmptyState
      },
      first_seat: {
        true => FirstSeatEmptyToOccupiedState,
        false => FirstSeatOccupiedToEmptyState
      }
    }
  end

  def adjacent_logic!
    self.logic_selector = :adjacent
  end

  def first_seat_logic!
    self.logic_selector = :first_seat
  end

  def transition_logic state
    strategies[logic_selector][state.empty?]
  end

  private

  attr_accessor :logic_selector, :strategies
end
