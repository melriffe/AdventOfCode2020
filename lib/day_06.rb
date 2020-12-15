##
# --- Day 6: Custom Customs ---
# https://adventofcode.com/2020/day/6
#
class Day06
  attr_accessor :data

  ##
  # 'data' is an Array[<String>], representing groups of questions
  # answered with a 'Yes'
  #
  # 'groups' of answers are separated by blank lines
  #
  def initialize data
    self.data = data
  end

  def exercise1
    yes_answers = 0
    group_yesses = ''

    data.each do |line|
      if line.chomp.length.zero?
        yes_answers += group_yesses.chars.uniq.size
        group_yesses = ''
      else
        group_yesses += line.chomp
      end
    end

    yes_answers += group_yesses.chars.uniq.size
    yes_answers
  end

  def exercise2
    0
  end

end