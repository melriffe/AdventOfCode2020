# frozen_string_literal: true

##
# --- Day 22: Crab Combat ---
# https://adventofcode.com/2020/day/22
#
class Day22
  attr_accessor :data

  ##
  # 'data' is an Array[<String>]. The entire set of data represents a
  # game of Crab Combat, a card-game for 2 players. The cards are
  # 'shuffled' and dealt between Player 1 & Player 2. A 'card' is
  # depicted as a numeric value.
  #
  def initialize data
    self.data = data
  end

  def exercise1
    parse_data
    game = CrabCombat.new crab_one, crab_two
    game.play!
    game.winning_score
  end

  def exercise2
    0
  end

  private

  attr_accessor :crab_one, :crab_two

  def parse_data
    blank_line = data.index ''
    data.slice!(0..blank_line).each do |line|
      next if line.chomp.strip.length.zero?

      if /^P/.match?(line)
        self.crab_one = Combatant.new line
      else
        crab_one.cards << line.to_i
      end
    end

    data.each do |line|
      next if line.chomp.strip.length.zero?

      if /^P/.match?(line)
        self.crab_two = Combatant.new line
      else
        crab_two.cards << line.to_i
      end
    end
  end
end

class ScoreCalculator

  def self.score cards
    result = 0
    cards.reverse.each_with_index do |value, index|
      result += (value * (index + 1))
    end
    result
  end

end

class Combatant
  attr_reader :cards

  def initialize name
    self.name = name
    self.cards = []
  end

  def continue?
    cards.any?
  end

  def play_card
    cards.shift
  end

  def round_winner more_cards
    self.cards += more_cards.sort.reverse
  end

  def score
    ScoreCalculator.score cards
  end

  private

  attr_accessor :name
  attr_writer :cards
end

class CrabCombat
  attr_reader :winner

  def initialize crab_one, crab_two
    self.crab_one = crab_one
    self.crab_two = crab_two
  end

  def play!
    while continue_to_play?
      play_a_round
    end
    determine_winner
  end

  def winning_score
    winner.score
  end

  attr_accessor :crab_one, :crab_two
  attr_writer :winner

  def continue_to_play?
    crab_one.continue? && crab_two.continue?
  end

  def play_a_round
    crab_one_card = crab_one.play_card
    crab_two_card = crab_two.play_card

    if crab_one_card > crab_two_card
      crab_one.round_winner [crab_one_card, crab_two_card]
    else
      crab_two.round_winner [crab_one_card, crab_two_card]
    end
  end

  def determine_winner
    self.winner = crab_one.continue? ? crab_one : crab_two
  end
end
