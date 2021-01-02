##
# --- Day 14: Docking Data ---
# https://adventofcode.com/2020/day/14
#
class Day14
  attr_accessor :data

  ##
  # 'data' is an Array[<String>], where "String" is a series of characters
  # representing program commands defining 'masks' and 'mem' locations
  #
  # The set represents an initialization program
  #
  def initialize data
    self.data = data
    parse_data
  end

  def exercise1
    computer_simulator.mask = Mask.new
    computer_simulator.run!
    computer_simulator.memory_values.sum
  end

  def exercise2
    0
  end

  private

  attr_accessor :computer_simulator

  def parse_data
    self.computer_simulator = ComputerSimulator.new data
  end
end

class MaskV2

end

class Mask

  def initialize
    self.mask = ''
  end

  def change new_mask
    self.mask = new_mask
    update_operands
  end

  def apply memory, slot:, input_value:
    memory[slot] = (input_value | or_operand) & and_operand
  end

  private

  attr_accessor :mask, :or_operand, :and_operand

  def update_operands
    update_or_operand
    update_and_operand
  end

  def update_or_operand
    or_mask = mask.gsub('X', '0')
    self.or_operand = or_mask.to_i(2)
  end

  def update_and_operand
    and_mask = mask.gsub('X', '1')
    self.and_operand = and_mask.to_i(2)
  end

end

class Memory

  def initialize
    self.accessible_memory = {}
  end

  def []= key, value
    accessible_memory[key] = value
  end

  def values
    accessible_memory.values
  end

  private

  attr_accessor :accessible_memory

end

class ComputerSimulator
  attr_accessor :mask

  def initialize program
    self.memory = Memory.new
    self.program = program
  end

  ##
  # There are 2 forms of 'instruction':
  #   'mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X',
  #   'mem[8] = 11',
  def run!
    program.each do |instruction|
      next if instruction.chomp.strip.length.zero?
      if instruction.match(/^mask/)
        mask.change instruction[7..-1]
      else
        parts = instruction.split(' = ')
        slot = parts.first.match(/\d+/)[0]
        input_value = parts.last.to_i
        mask.apply( memory, slot: slot, input_value: input_value )
      end
    end
  end

  def memory_values
    memory.values
  end

  private

  attr_accessor :memory, :program

end
