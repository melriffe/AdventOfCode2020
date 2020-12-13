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
    passports.select { |passport| passport.valid? }.size
  end

  def exercise2
    0
  end

  private

  attr_accessor :passports

  def parse_data
    self.passports = []
    passports_fields = []
    data.each do |line|
      if line.chomp.length.zero?
        self.passports << Passport.new( passports_fields )
        passports_fields = []
      else
        passports_fields << line.chomp
      end
    end
  end

end

class Passport
  def initialize field_data
    self.parse_data field_data
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
    fields.size == 8 || (fields.size == 7 && cid_missing?)
  end

  def cid_missing?
    !cid_present?
  end

  def cid_present?
    fields.key? 'cid'
  end

  private

  attr_accessor :fields

  def parse_data field_data
    self.fields = {}
    field_data.each do |field_line|
      associations = field_line.split(' ')
      associations.each do |association|
        parts = association.split(':')
        self.fields[parts.first] = parts.last
      end
    end
    self.fields
  end
end
