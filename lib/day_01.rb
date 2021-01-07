##
# --- Day 1: Report Repair ---
# https://adventofcode.com/2020/day/1
#
class Day01
  attr_accessor :data

  def initialize data
    self.data = data
  end

  ##
  # Against the specified list of numbers (i.e. 'data') find the pair
  # that equals 2020 and return their product
  #
  def exercise1
    length = data.length
    return 0 if length.zero?

    data.each_with_index do |first, index|
      data.slice(index+1, length).each do |second|
        return first * second if first + second == 2020
      end
    end
  end

  ##
  # Against the specified list of numbers (i.e. 'data') find the trio
  # that equals 2020 and return their product
  #
  def exercise2
    length = data.length
    return 0 if length.zero?

    data.each_with_index do |first, index|
      data2 = data.slice(index+1, length)
      data2.each_with_index do |second, index2|
        data2.slice(index2+1, length).each do |third|
          return first * second * third if first + second + third == 2020
        end
      end
    end
  end
end
