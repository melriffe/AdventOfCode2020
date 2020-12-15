##
# --- Day 5: Binary Boarding ---
# https://adventofcode.com/2020/day/5
#
class Day05
  attr_accessor :data

  ##
  # 'data' is an Array[<String>], representing a set of boarding
  # passes
  #
  def initialize data
    self.data = data
  end

  def exercise1
    parse_data
    boarding_passes.collect { |bording_pass| bording_pass.seat_id }.max
  end

  def exercise2
    0
  end

  private

  attr_accessor :boarding_passes

  def parse_data
    self.boarding_passes = []
    data.each do |line|
      boarding_passes << BoardingPass.new(line)
    end
  end
end

# binary space partitioning
#
# A seat might be specified like FBFBBFFRLR, where F means "front",
# B means "back", L means "left", and R means "right".
#
# The first 7 characters (F or B) denote the row
# The last 3 characters (L or R) denote the column
#
# A plane has 0 to 127 rows, and each row has 0 to 7 columns
#
# A seat has an ID which equals: (the row * 8) + column
#
# Therefore, FBFBBFFRLR = 357
#
class BoardingPass
  attr_reader :column, :row

  def initialize code
    self.column = self.row = 0
    self.parse_code code
  end

  def seat_id
    (row * 8) + column
  end

  private

  attr_writer :column, :row

  ##
  # The first 7 characters will either be F or B; these
  # specify exactly one of the 128 rows on the plane (numbered 0
  # through 127). Each letter tells you which half of a region the
  # given seat is in. Start with the whole list of rows; the first
  # letter indicates whether the seat is in the front (0 through 63)
  # or the back (64 through 127). The next letter indicates which
  # half of that region the seat is in, and so on until you're left
  # with exactly one row.
  #
  # The last three characters will be either L or R; these specify
  # exactly one of the 8 columns of seats on the plane (numbered 0
  # through 7). The same process as above proceeds again, this time
  # with only three steps. L means to keep the lower half, while R
  # means to keep the upper half.
  #
  # NOTE: I'm assuming call specified codes will be 10 characters
  #
  def parse_code code
    row_code = code[0,7]
    column_code = code[7,3]

    parse_row_code row_code
    parse_colum_code column_code
  end

  ##
  # Given a 7-character code, return a number between 0 and 127.
  #
  # Each letter denotes to which half the next letter will be applied.
  #
  # NOTE: There is no validation. 'F' & 'B' are assumed to be the only
  # letters present.
  #
  def parse_row_code code
    rows = (0..127).to_a
    half_count = rows.length / 2

    code.each_char do |char|
      case char
      when 'F'
        rows = rows[0, half_count]
      when 'B'
        rows = rows[half_count, half_count]
      end

      half_count = rows.length / 2
    end

    self.row = rows.first
  end

  ##
  # Given a 3-character code, return a number between 0 and 7.
  #
  # Each letter deontes to which half the next letter will be applied.
  #
  # NOTE: There is no validation. 'L' & 'R' are assumed to be the only
  # letters present.
  #
  def parse_colum_code code
    columns = (0..7).to_a
    half_count = columns.length / 2

    code.each_char do |char|
      case char
      when 'L'
        columns = columns[0, half_count]
      when 'R'
        columns = columns[half_count, half_count]
      end

      half_count = columns.length / 2
    end

    self.column = columns.first
  end

end