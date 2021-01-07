##
# --- Day 9: Encoding Error ---
# https://adventofcode.com/2020/day/9
#
class Day09
  attr_accessor :data

  ##
  # 'data' is an Array[<String>], where "String" is a digit. It represents
  # a set of data entryped by an old cypher: XMAS.
  #
  # Starting with a preample of N size, the digit at N+1 is the sum of 2
  # digits within the preamble. This preamble moves as the digits progress.
  #
  def initialize data
    self.data = data
  end

  def exercise1 preamble:
    parse_data

    preamble_size = preamble + 1
    preamble_stop = preamble_size
    while (preamble_stop < encrypted_data.length)
      preamble_start = preamble_stop - preamble_size
      data = encrypted_data[preamble_start, preamble_size]

      unless contains_addends? data[preamble], data[0, preamble]
        return data[preamble]
      end

      preamble_stop += 1
    end

    0
  end

  def exercise2 invalid_value:
    parse_data

    index = 0
    count = 1

    while (index < encrypted_data.length)

      until (encrypted_data[index, count].sum >= invalid_value)
        count += 1
      end

      if encrypted_data[index, count].sum == invalid_value
        min = encrypted_data[index, count].min
        max = encrypted_data[index, count].max
        return min + max
      end

      index += 1
      count = 1
    end

    0
  end

  private

  attr_accessor :encrypted_data

  def parse_data
    self.encrypted_data = data.collect do |line|
      next if line.chomp.strip.length.zero?

      line.to_i
    end
  end

  def contains_addends? sum, addends
    addends.each_with_index do |first, index|
      addends.slice(index+1, addends.length).each do |second|
        return true if first + second == sum
      end
    end
    false
  end
end
