##
# --- Day 16: Ticket Translation ---
# https://adventofcode.com/2020/day/16
#
class Day16
  attr_accessor :data

  ##
  # 'data' is an Array[<String>]. This Array represents structured
  # information, separated by blank lines. The first group is considered
  # rules for ticket fields. The second group, starting with 'your
  # ticket:', represents the numbers on your ticket. The third group,
  # starting with 'nearby tickets:', represents numbers on nearby
  # tickets.
  #
  def initialize data
    self.data = data
  end

  def exercise1
    parse_data
    self.ticket_scanner = TicketScanner.new rules, nearby_tickets
    ticket_scanner.scanning_error_rate
  end

  def exercise2
    0
  end

  private

  attr_accessor :ticket_scanner, :my_ticket, :nearby_tickets, :rules

  def parse_data
    # Parse out the rules for the ticket fields:
    self.rules = []
    empty_line_index = data.index ''
    field_rules = data.slice!((0..empty_line_index))
    field_rules.each do |specification|
      next if specification.strip.length.zero?
      rules << Rule.new(specification)
    end

    # Parse out my ticket:
    self.my_ticket = Ticket.new
    empty_line_index = data.index ''
    ticket_specifications = data.slice!((0..empty_line_index))
    ticket_specifications.each do |line|
      next if line.strip.length.zero?
      next if line.match(/ticket/)
      field_values = line.split(',')
      field_values.each do |value|
        my_ticket.add_field Field.new(value.to_i)
      end
    end

    # Parse out nearby tickets
    self.nearby_tickets = []
    data.each do |line|
      next if line.strip.length.zero?
      next if line.match(/ticket/)
      ticket = Ticket.new
      field_values = line.split(',')
      field_values.each do |value|
        ticket.add_field Field.new(value.to_i)
      end
      nearby_tickets << ticket
    end

  end
end

class TicketScanner

  def initialize rules, tickets
    self.rules = rules
    self.tickets = tickets
  end

  def scanning_error_rate
    tickets.each { |ticket| ticket.validate rules }
    invalid_values = tickets.collect do |ticket|
      ticket.invalid_fields.map(&:value)
    end
    invalid_values.flatten.sum
  end

  private

  attr_accessor :rules, :tickets

end

class Ticket

  def initialize
    self.fields = []
  end

  def add_field field
    fields << field
  end

  def validate rules
    fields.each { |field| field.validate rules }
  end

  def invalid_fields
    fields.reject { |field| field.valid? }
  end

  private

  attr_accessor :fields, :rules

end

class Field
  attr_reader :value

  def initialize value
    self.value = value
    self.valid = false
  end

  def validate rules
    checks = rules.collect { |rule| rule.value_valid? value }
    if checks.any?
      valid!
    else
      invalid!
    end
  end

  def valid?
    valid
  end

  def valid!
    self.valid = true
  end

  def invalid!
    self.valid = false
  end

  private

  attr_accessor :valid
  attr_writer :value

end

class Rule

  def initialize specification
    parse specification
  end

  def value_valid? value
    range1.cover?(value) || range2.cover?(value)
  end

  private

  attr_accessor :field_name, :range1, :range2

  ##
  # Expected rule format: <label>: range1 or range2
  # where range is n-N
  # with n occuring before N
  #
  # Example:
  #   'class: 1-3 or 5-7'
  #
  def parse specification
    parts = specification.split(': ')
    self.field_name = parts.first

    parts = parts.last.split(' or ')
    range_parts = parts.first.split('-')
    self.range1 = Range.new range_parts.first.to_i, range_parts.last.to_i
    range_parts = parts.last.split('-')
    self.range2 = Range.new range_parts.first.to_i, range_parts.last.to_i
  end
end
