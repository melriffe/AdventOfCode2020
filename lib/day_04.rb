# frozen_string_literal: true
##
# --- Day 4: Passport Processing ---
# https://adventofcode.com/2020/day/4
#
class Day04
  attr_accessor :data

  ##
  # The incoming data is a 'batch' of 'passports'.
  # Passports are sepearated by blank lines; Passport fields are separated by spaces
  def initialize data
    self.data = data
  end

  ##
  # Based on the current batch of 'passports', return the number of
  # valid passports.
  #
  # Special Rule: `cid` is optional; If the only field missing is `cid`
  # the passport is considered valid, otherwise it is invalid.
  def exercise1
    parse_data
    passports.count { |passport| passport.valid? }
  end

  def exercise2
    parse_data true
    passports.count { |passport| passport.valid? }
  end

  private

  attr_accessor :passports

  def parse_data field_validation = false
    self.passports = []
    passports_fields = []
    data.each do |line|
      if line.chomp.length.zero?
        passports << Passport.new(passports_fields, field_validation)
        passports_fields = []
      else
        passports_fields << line.chomp
      end
    end
  end
end

class Passport
  def initialize field_data, field_validation = false
    parse_data field_data
    self.field_validation = field_validation
  end

  # detecting which passports have all required fields; expected fields:
  #   byr (Birth Year)
  #   iyr (Issue Year)
  #   eyr (Expiration Year)
  #   hgt (Height)
  #   hcl (Hair Color)
  #   ecl (Eye Color)
  #   pid (Passport ID)
  #   cid (Country ID)
  #
  def valid?
    if field_validation
      required_fields_present? && present_fields_valid?
    else
      required_fields_present?
    end
  end

  def cid_missing?
    !cid_present?
  end

  def cid_present?
    fields.key? 'cid'
  end

  private

  attr_accessor :fields, :field_validation

  def parse_data field_data
    self.fields = {}
    field_data.each do |field_line|
      associations = field_line.split(' ')
      associations.each do |association|
        parts = association.split(':')
        fields[parts.first] = PassportField.new(parts.first, parts.last)
      end
    end
    fields
  end

  def required_fields_present?
    fields.size == 8 || (fields.size == 7 && cid_missing?)
  end

  def present_fields_valid?
    fields.each do |_, field|
      return false unless field.valid?
    end
    true
  end
end

class PassportField
  attr_accessor :name, :value

  def initialize name, value
    self.name = name
    self.value = value
  end

  def valid?
    validator.valid?
  end

  def validator
    @validator ||= PassportFieldValidator.validator(self)
  end
end

##
# Validation rules for the Passport Fields:
#
# byr (Birth Year) - four digits; at least 1920 and at most 2002.
#
class BirthYearValidator
  attr_accessor :passport_field

  def initialize passport_field, min = 1920, max = 2002
    self.passport_field = passport_field
    self.min = min
    self.max = max
  end

  def valid?
    value = passport_field.value
    value.match(/\d{4}/) && (value.to_i <= max && value.to_i >= min)
  end

  private

  attr_accessor :max, :min
end

##
# Validation rules for the Passport Fields:
#
# iyr (Issue Year) - four digits; at least 2010 and at most 2020.
#
class IssueYearValidator
  attr_accessor :passport_field

  def initialize passport_field, min = 2010, max = 2020
    self.passport_field = passport_field
    self.min = min
    self.max = max
  end

  def valid?
    value = passport_field.value
    value.match(/\d{4}/) && (value.to_i <= max && value.to_i >= min)
  end

  private

  attr_accessor :max, :min
end

##
# Validation rules for the Passport Fields:
#
# eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
#
class ExpirationYearValidator
  attr_accessor :passport_field

  def initialize passport_field, min = 2020, max = 2030
    self.passport_field = passport_field
    self.min = min
    self.max = max
  end

  def valid?
    value = passport_field.value
    value.match(/\d{4}/) && (value.to_i <= max && value.to_i >= min)
  end

  private

  attr_accessor :max, :min
end

##
# Validation rules for the Passport Fields:
#
# hgt (Height) - a number followed by either cm or in:
#   If cm, the number must be at least 150 and at most 193.
#   If in, the number must be at least 59 and at most 76.
#
class HeightValidator
  attr_accessor :passport_field

  def initialize passport_field
    self.passport_field = passport_field
  end

  def valid?
    value = passport_field.value
    case value
    when /in$/
      valid_imperial_value? value.to_i
    when /cm$/
      valid_metric_value? value.to_i
    else
      false
    end
  end

  private

  def valid_metric_value? value
    value <= 193 && value >= 150
  end

  def valid_imperial_value? value
    value <= 76 && value >= 59
  end
end

##
# Validation rules for the Passport Fields:
#
# hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
#
class HairColorValidator
  attr_accessor :passport_field

  def initialize passport_field
    self.passport_field = passport_field
  end

  def valid?
    value = passport_field.value
    !value.match(/#([0-9]|[a-f]){6}$/).nil?
  end
end

##
# Validation rules for the Passport Fields:
#
# ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
#
class EyeColorValidator
  attr_accessor :passport_field

  def initialize passport_field
    self.passport_field = passport_field
  end

  def valid?
    value = passport_field.value
    valid_values.include? value
  end

  private

  def valid_values
    %w[amb blu brn gry grn hzl oth]
  end
end

##
# Validation rules for the Passport Fields:
#
# pid (Passport ID) - a nine-digit number, including leading zeroes.
#
class PassportIdValidator
  attr_accessor :passport_field

  def initialize passport_field
    self.passport_field = passport_field
  end

  def valid?
    value = passport_field.value
    !value.match(/^\d{9}$/).nil?
  end
end

##
# Validation rules for the Passport Fields:
#
# cid (Country ID) - ignored, missing or not.
#
class CountryIdValidator
  attr_accessor :passport_field

  def initialize passport_field
    self.passport_field = passport_field
  end

  def valid?
    true
  end
end

##
# This class needs a better name.
#
class PassportFieldValidator
  VALIDATORS = {
    'byr' => ::BirthYearValidator,
    'iyr' => ::IssueYearValidator,
    'eyr' => ::ExpirationYearValidator,
    'hgt' => ::HeightValidator,
    'hcl' => ::HairColorValidator,
    'ecl' => ::EyeColorValidator,
    'pid' => ::PassportIdValidator,
    'cid' => ::CountryIdValidator
  }.freeze

  def self.validator passport_field
    VALIDATORS[passport_field.name].new(passport_field)
  end
end
