# frozen_string_literal: true

##
# --- Day 20: Jurassic Jigsaw ---
# https://adventofcode.com/2020/day/20
#
class Day20
  attr_accessor :data

  ##
  # 'data' is an Array[<String>]. The entire set represents a group of
  # images/tiles. Each image is separated by a blank line in the data.
  # An image consists of a Tile Id, along with 10 lines of image data.
  #
  def initialize data
    self.data = data
  end

  def exercise1
    0
  end

  def exercise2
    0
  end

  private

  def parse_data
    # data[0][/\d+/] => "2311"
    # data[1][/\d+/] => nil
    # Math.sqrt( number of tiles ) equals how many tiles per side to produce a square
  end
end

class ImageTile

  def initialize id, data
    self.id = id.to_i
    pixelate data
  end

  def top
    border[:top]
  end

  def left
    border[:left]
  end

  def bottom
    border[:bottom]
  end

  def right
    border[:right]
  end

  ##
  # Rotate the edges 1 step 'right'; top becomes right, right
  # becomes bottom, bottom becomes left, and left becomes top.
  #
  def rotate_r
    border[:temp] = top
    border[:top] = left
    border[:left] = bottom
    border[:bottom] = right
    border[:right] = border[:temp]
    border.delete(:temp)
    self
  end

  ##
  # Rotate the edges 1 step 'left'; top becomes left, left
  # becomes bottom, bottom becomes right, and right becomes top.
  #
  def rotate_l
    border[:temp] = top
    border[:top] = right
    border[:right] = bottom
    border[:bottom] = left
    border[:left] = border[:temp]
    border.delete(:temp)
    self
  end

  ##
  # Flip the edges on the horizontal axis; top becomes bottom,
  # bottom becomes top, left & right flip upside down.
  #
  def flip_h
    border[:temp] = top
    border[:top] = bottom
    border[:bottom] = border[:temp]
    border[:right] = right.reverse
    border[:left] = left.reverse
    border.delete(:temp)
    self
  end

  ##
  # Flip the edges on the vertical axis; left becomes right, right
  # becomes left, top and bottom flip sideways.
  #
  def flip_v
    border[:temp] = left
    border[:left] = right
    border[:right] = border[:temp]
    border[:top] = top.reverse
    border[:bottom] = bottom.reverse
    border.delete(:temp)
    self
  end

  private

  attr_accessor :id, :pixels

  def border
    @border ||= find_border
  end

  ##
  # Initially, the edges will be based on the incoming data. "top" will
  # be oriented left to right; "bottom" will be oriented left to right;
  # "left" will be oriented top to bottom; "right" will be oriented top
  # to bottom.
  #
  def find_border
    edges = {
      top:    pixels.first.join,
      left:   pixels.map(&:first).join,
      bottom: pixels.last.join,
      right:  pixels.map(&:last).join
    }

    edges
  end

  ##
  # The layout of the original data as it was loaded. These do not change
  # when a tile is rotated and/or flipped.
  #
  def pixelate data
    self.pixels = []
    data.each do |line|
      pixels << line.chars
    end
  end
end

class Image

  def initialize tiles
    self.tiles = tiles
  end

  def corners
    [0, 0, 0, 0]
  end

  private

  attr_accessor :tiles
end
