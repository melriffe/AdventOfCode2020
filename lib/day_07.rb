require 'set'

##
# --- Day 7: Handy Haversacks ---
# https://adventofcode.com/2020/day/7
#
class Day07
  attr_accessor :data

  ##
  # 'data' is an Array[<String>], representing rules describing the
  # relationships between differenly colored bags.
  #
  def initialize data
    self.data = data
  end

  ##
  #
  #
  def exercise1
    parse_data
    bag = luggage_policy.bag_called 'shiny-gold'
    bag.enclosing_bags.size
  end

  def exercise2
    parse_data
    bag = luggage_policy.bag_called 'shiny-gold'
    bag.enclosed_bags - 1
  end

  private

  attr_accessor :luggage_policy

  ##
  #
  def parse_data
    self.luggage_policy = LuggagePolicy.new
    data.each do |line|
      next if line.chomp.strip.length.zero?

      rule = LineParser.parse line
      rule.each_pair do |name, enclosed_bags|
        bag = luggage_policy.bag_called name
        enclosed_bags.each do |enclosed_bag|
          enclosed_bag.each_pair do |_name, quantity|
            _bag = luggage_policy.bag_called _name
            bag.enclose _bag, occurrences: quantity
          end
        end
      end
    end
  end
end

class LineParser
  ##
  # Return Hash of parsed bits of the incoming line; { rule => [definitions] }
  #
  # descriptor bags contain [count] descriptor bag[, [count] descriptor*]
  # descriptor bags contain [no other bags.]
  #
  # Generalized:
  #   rule => definition
  #
  def self.parse line
    parts = line.delete('.').split(' contain ')

    rule_descriptor = parse_descriptor parts.first
    definition = parts.last.strip

    if definition.match(/no other bags/)
      definition_descriptors = []
    else
      definition_descriptors = definition.split(', ').collect do |descriptor|
        contains_descriptior = parse_descriptor descriptor
        parts = contains_descriptior.split(' ')
        { parts.first => parts.last.to_i }
      end
    end

    { rule_descriptor => definition_descriptors }
  end

  ##
  # 'adjective color bag(s)' => 'adjective-color'
  # 'quantity adjective color bag(s)' => 'adjective-color quantity'
  #
  def self.parse_descriptor descriptor
    descriptor_parts = descriptor.split(' ')
    if descriptor_parts.first.match(/\d+/)
      "#{descriptor_parts[1]}-#{descriptor_parts[2]} #{descriptor_parts[0]}"
    else
      "#{descriptor_parts[0]}-#{descriptor_parts[1]}"
    end
  end
end

##
# NOTE: This models the concept of the luggage bags, not the data
# structure Bag.
#
class Bag
  attr_reader :name

  def initialize name
    self.name = name
    self.contains = {}
    self.enclosing = Set.new
  end

  def eql? other_key
    name == other_key.name
  end

  def hash
    name.hash
  end

  def enclose bag, occurrences: 1
    contains[bag] = occurrences
    bag.enclosed_by self
  end

  def enclosed_by bag
    enclosing.add bag
  end

  def enclosing_bags set = Set.new
    enclosing.each do |bag|
      unless set.include? bag
        set.add bag
        bag.enclosing_bags set
      end
    end
    set
  end

  def enclosed_bags
    count = 1
    contains.each_pair do |bag, occurrences|
      count = count + (occurrences * bag.enclosed_bags)
    end
    count
  end

  private

  attr_accessor :contains, :enclosing
  attr_writer :name
end

class LuggagePolicy
  def bags
    @bags ||= Hash.new { |hash, key| hash[key] = Bag.new key }
  end

  def bag_called name
    bags[name]
  end
end
