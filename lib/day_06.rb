# frozen_string_literal: true
##
# --- Day 6: Custom Customs ---
# https://adventofcode.com/2020/day/6
#
class Day06
  attr_accessor :data

  ##
  # 'data' is an Array[<String>], representing groups of questions
  # answered with a 'Yes'
  #
  # 'groups' of answers are separated by blank lines; a line represents
  # one person answering questions.
  #
  # The form asks a series of 26 yes-or-no questions marked a through z.
  #
  def initialize data
    self.data = data
  end

  ##
  # For the groups of answered questions, count how many unique questions
  # were answered yes.
  #
  def exercise1
    parse_data
    groups.inject(0) { |sum, group| sum + group.answered_count }
  end

  ##
  # For the groups of answered questions, count how many questions were
  # answered by everyone in the group.
  #
  def exercise2
    parse_data
    groups.inject(0) { |sum, group| sum + group.question_count }
  end

  private

  attr_accessor :groups

  def parse_data
    self.groups = []
    group = Group.new
    data.each do |line|
      if line.chomp.length.zero?
        groups << group
        group = Group.new
      else
        person = Person.new line.chomp
        group.people << person
      end
    end
    groups << group # Save the last group
  end
end

class Group
  def people
    @people ||= []
  end

  ##
  # Returns the count of unique questions answered
  #
  def answered_count
    people.collect { |person| person.answered }.flatten.uniq.size
  end

  ##
  # Returns the count of same questions answered
  #
  def question_count
    return people.first.answered.size if people.length == 1

    people_answering = people.length
    questions = Hash.new 0
    people.each do |person|
      person.answered.each do |char|
        questions[char] += 1
      end
    end

    count = 0
    questions.each do |_, value|
      count += 1 if value == people_answering
    end
    count
  end
end

class Person
  ##
  # 'questions' is a line of characters that represents the
  # questions this person answered
  #
  def initialize questions
    self.questions = questions
  end

  ##
  # Return 'questions' as an Array[<Character>], sorted
  #
  def answered
    questions.chars.sort
  end

  private

  attr_accessor :questions
end
