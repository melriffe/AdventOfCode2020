# frozen_string_literal: true
require 'set'

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
    parse_data
    image = Image.new image_tiles
    image.reassemble
    image.corners.reduce(&:*)
  end

  def exercise2
    0
  end

  private

  attr_accessor :image_tiles

  def parse_data
    self.image_tiles = []
    until data.empty?
      blank_line = data.index ''

      if blank_line.nil?
        tile_id, tile_data = parse_image_tile data
        data.clear
      else
        tile_id, tile_data = parse_image_tile data.slice!(0..blank_line)
      end

      image_tiles << ImageTile.new(tile_id, tile_data)
    end
  end

  def parse_image_tile data
    tile_id = 0
    tile_data = []
    data.each do |line|
      next if line.chomp.strip.length.zero?

      if /^T/.match?(line)
        tile_id = line[/\d+/]
      else
        tile_data << line
      end
    end
    [tile_id, tile_data]
  end
end

class ImageTile
  attr_reader :id

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

  attr_accessor :pixels
  attr_writer :id

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
    {
      top: pixels.first.join,
      left: pixels.map(&:first).join,
      bottom: pixels.last.join,
      right: pixels.map(&:last).join
    }
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
    self.neighbors = Hash.new { |hash, key| hash[key] = Set.new }
  end

  def reassemble
    tile_locator = TileLocator.new self
    tile_locator.relocate tiles
    self
  end

  def neighbors! tile_a, tile_b
    neighbors[tile_a.id] << tile_b.id
    neighbors[tile_b.id] << tile_a.id
  end

  # NOTE: These are the images with only 2 neighbors
  def corners
    neighbors.select { |_, v| v.size == 2 }.keys
  end

  private

  attr_accessor :neighbors, :tiles
  # Math.sqrt( number of tiles ) equals how many tiles per side to produce a square
end

class TileLocator
  def initialize image
    self.image = image
  end

  def relocate tiles
    length = tiles.count
    tiles.each_with_index do |first, index|
      tiles.slice(index + 1, length).each do |second|
        image.neighbors! first, second if neighbors? first, second
      end
    end
  end

  private

  attr_accessor :image

  def neighbors? tile_a, tile_b
    next_to_each_other = false

    # NOTE: First check in 'original' positions
    4.times do
      break if next_to_each_other

      tile_a.rotate_r

      next_to_each_other = tile_b.bottom == tile_a.top ||
                           tile_b.left   == tile_a.right ||
                           tile_b.top    == tile_a.bottom ||
                           tile_b.right  == tile_a.left
    end

    ## NOTE: Check when horizontally flipped
    tile_a.flip_h
    4.times do
      break if next_to_each_other

      tile_a.rotate_r

      next_to_each_other = tile_b.bottom == tile_a.top ||
                           tile_b.left   == tile_a.right ||
                           tile_b.top    == tile_a.bottom ||
                           tile_b.right  == tile_a.left
    end
    tile_a.flip_h

    ## NOTE: Check when vertically flipped
    tile_a.flip_v
    4.times do
      break if next_to_each_other

      tile_a.rotate_r

      next_to_each_other = tile_b.bottom == tile_a.top ||
                           tile_b.left   == tile_a.right ||
                           tile_b.top    == tile_a.bottom ||
                           tile_b.right  == tile_a.left
    end
    tile_a.flip_v

    next_to_each_other
  end
end
