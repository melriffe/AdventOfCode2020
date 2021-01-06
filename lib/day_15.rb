##
# --- Day 15: Rambunctious Recitation ---
# https://adventofcode.com/2020/day/15
#
class Day15
  attr_accessor :data

  ##
  # 'data' is a String of comma-separated numbers; the starting numbers
  #
  def initialize data
    self.data = data
  end

  def exercise1
    parse_data
    while(true)
      turn, number = memory_game.speak_number
      break if turn == 2_020
    end
    number
  end

  def exercise2
    parse_data
    while(true)
      turn, number = memory_game.speak_number
      break if turn == 30_000_000
    end
    number
  end

  private

  attr_accessor :memory_game, :starting_numbers

  def parse_data
    self.starting_numbers = []
    data.each do |line|
      next if line.chomp.strip.length.zero?
      line.split(',').each do |number|
        starting_numbers << number.strip.to_i
      end
    end
    self.memory_game = MemoryGame.new starting_numbers
  end
end

class MemoryGame

  def initialize starting_numbers
    self.numbers_spoken = Hash.new { |hash, key| hash[key] = [] }
    self.starting_numbers = starting_numbers
    starting_numbers.unshift('-') # Line up indexes with turns
    self.turn = 0
  end

  def speak_number
    advance_turn_keeper
    get_next_number

    [turn, next_number]
  end

  private

  attr_accessor :last_number, :next_number, :numbers_spoken
  attr_accessor :starting_numbers, :turn

  def advance_turn_keeper
    self.turn += 1
  end

  def get_next_number
    if consider_last_number_spoken?
      self.next_number = consider_last_number
      self.last_number = next_number
    else
      self.next_number = starting_numbers[turn]
      self.last_number = next_number
    end
    numbers_spoken[next_number].unshift(turn) # Make sure 'turn' is 1st element
  end

  def consider_last_number_spoken?
    turn >= starting_numbers.length
  end

  def consider_last_number
    return last_number_age if last_number_spoken_before?
    0
  end

  def last_number_spoken_before?
    numbers_spoken[last_number].size > 1
  end

  def last_number_age
    mentions = numbers_spoken[last_number]
    mentions.pop if mentions.size > 2
    mentions.first - mentions.last
  end
end
