# frozen_string_literal: true
##
# --- Day 18: Operation Order ---
# https://adventofcode.com/2020/day/18
#
class Day18
  attr_accessor :data

  ##
  # 'data' is an Array[<String>]. Each string represents a mathmatical
  # expression to solve.
  #
  def initialize data
    self.data = data
  end

  def exercise1
    parse_data
    homework = Homework.new math_problems
    homework.finish
  end

  def exercise2
    0
  end

  private

  attr_accessor :math_problems

  def parse_data
    self.math_problems = []
    data.each do |line|
      next if line.strip.length.zero?
      math_problems << MathProblem.new(line)
    end
  end
end

class Homework

  def initialize math_problems
    self.math_problems = math_problems
  end

  def finish
    math_problems.sum { |math_problem| math_problem.solve }
  end

  private

  attr_accessor :math_problems
end

class Tree
  attr_accessor :data, :left, :right

  def initialize data
    self.data = data
  end

  def leaf?
    left.nil? && right.nil?
  end

end

class MathProblem
  attr_accessor :expression

  def initialize input
    self.expression = input.gsub(/\s+/, '') # Remove incoming spaces
  end

  ##
  # Construct Binary Expression Tree from the specified expression.
  #
  # Resources Used:
  #  - https://www.geeksforgeeks.org/program-to-convert-infix-notation-to-expression-tree/?ref=rp
  #  - https://stackoverflow.com/questions/7196430/implementing-tree-with-ruby
  #  - https://medium.com/amiralles/mastering-data-structures-in-ruby-binary-trees-e7c001050a52
  #  - https://gist.github.com/amiralles/64125ccb3a7e478559a33305f9610762?ts=2
  #  - https://www.informit.com/articles/article.aspx?p=26943&seqNum=5
  #  - https://en.wikipedia.org/wiki/Binary_expression_tree
  #  - https://www.geeksforgeeks.org/evaluation-of-expression-tree/?ref=rp
  #
  def build
    nodes = []
    chars = []

    expression.each_char do |character|

      if '(' == character

        chars << character

      elsif /\d+/.match(character)

        nodes.push Tree.new(character.to_i)

      elsif operands.include?(character)

        while(chars.any? && chars.last != '(')
          t = Tree.new(chars.pop)
          t.right = nodes.pop
          t.left = nodes.pop
          nodes << t
        end

        chars << Operation::OPERATIONS[character].new

      elsif ')' == character

        while(chars.any? && chars.last != '(')
          t = Tree.new(chars.pop)
          t.right = nodes.pop
          t.left = nodes.pop
          nodes << t
        end

        chars.pop

      end

    end

    unless nodes.empty? && chars.empty?
      self.root = Tree.new(chars.pop)
      root.right = nodes.pop
      root.left = nodes.pop
    end

    raise "Ka-Blam! You still have nodes and/or chars" if nodes.any? || chars.any?

    root
  end

  def solve
    build if root.nil?
    evaluate(root)
  end

  private

  attr_accessor :root

  def operands
    %w[+ *]
  end

  def evaluate(node)
    return 0 if node.nil?
    return node.data if node.leaf?

    left_value = evaluate(node.left)
    right_value = evaluate(node.right)

    node.data.compute left_value, right_value
  end

end

class Addition

  def compute augend, addend
    augend + addend
  end

  def addition?
    true
  end

  def multiplication?
    false
  end

end

class Multiplication

  def compute multiplicand, multiplier
    multiplicand * multiplier
  end

  def addition?
    false
  end

  def multiplication?
    true
  end

end

class Operation
  OPERATIONS = {
    '+' => Addition,
    '*' => Multiplication
  }.freeze

end
