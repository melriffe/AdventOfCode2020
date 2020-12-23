##
# --- Day 8: Handheld Halting ---
# https://adventofcode.com/2020/day/8
#
class Day08
  attr_accessor :data

  ##
  # 'data' is an Array[<String>], and represents "boot code" where
  # each line is an "instruction". Each "instruction" represents an
  # "operation" and an "argument"
  #
  def initialize data
    self.data = data
  end

  def exercise1
    cpu = Cpu.load data
    cpu.run!
    cpu.accumulator.value
  end

  def exercise2
    cpu = Cpu.load data
    cpu.instructions.length.times do |index|
      cpu.toggle_instruction index
      if cpu.run!
        return cpu.accumulator.value
      else
        cpu.toggle_instruction index
      end
    end
  end

end

class Accumulator
  attr_reader :value

  def initialize
    self.value = 0
  end

  def change value
    self.value += value
  end

  private

  attr_writer :value

end


class Instruction
  attr_accessor :argument, :cpu

  def initialize argument:, cpu:
    self.argument = argument
    self.cpu = cpu
    self.executed = false
  end

  def advance
    self.executed = true
    cpu.next_instruction advancement
  end

  def executed?
    executed
  end

  def clear_executed!
    self.executed = false
  end

  def advancement
    1
  end

  def toggle_nop_jmp
    self
  end

  private

  attr_accessor :executed
end

class Acc < Instruction

  def advance
    cpu.accumulator.change argument
    super
  end
end

class Jmp < Instruction

  def advancement
    argument
  end

  def toggle_nop_jmp
    NoOp.new( argument: argument, cpu: cpu)
  end
end

class NoOp < Instruction

  def toggle_nop_jmp
    Jmp.new( argument: argument, cpu: cpu)
  end
end

class Cpu
  attr_reader :accumulator

  OPCODES = {
    'acc' => Acc,
    'jmp' => Jmp,
    'nop' => NoOp
  }

  def self.load boot_code
    new boot_code
  end

  def initialize boot_code
    add_instructions boot_code
  end

  def instructions
    @instructions ||= []
  end

  def next_instruction index
    self.current_instruction += index
  end

  def toggle_instruction index
    instructions[index] = instructions[index].toggle_nop_jmp
  end

  def run!
    self.accumulator = Accumulator.new
    self.current_instruction = 0
    instructions.map(&:clear_executed!)
    while(current_instruction < last_instruction)
      instruction = instructions[current_instruction]
      return false if instruction.executed?
      instruction.advance
    end
    true
  end

  private

  attr_accessor :current_instruction, :last_instruction
  attr_writer :accumulator,

  def add_instructions boot_code
    boot_code.each do |line|
      next if line.chomp.strip.length.zero?
      parts = line.split(' ')
      self.instructions << OPCODES[parts.first].new( argument: parts.last.to_i, cpu: self )
    end
    self.last_instruction = boot_code.length
  end

end
