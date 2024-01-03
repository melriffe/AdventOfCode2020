# frozen_string_literal: true

##
# --- Day 21: Allergen Assessment ---
# https://adventofcode.com/2020/day/21
#
class Day21
  attr_accessor :data

  ##
  # 'data' is an Array[<String>]. The entire set of data represents a
  # list of foods, one 'food' per line. Each line includes that food's
  # ingredients list followed by some or all of the allergens the food
  # contains.
  #
  def initialize data
    self.data = data
  end

  def exercise1
    parse_data
    food_inspector = FoodInspector.new foods
    food_inspector.non_allergen_ingredients.count
  end

  def exercise2
    parse_data
    food_inspector = FoodInspector.new foods
    food_inspector.dangerous_ingredient_list
  end

  private

  attr_accessor :foods

  def parse_data
    self.foods = []
    data.each do |line|
      # 'mxmxvkd kfcds sqjhc nhms (contains dairy, fish)'
      next if line.chomp.strip.length.zero?

      # NOTE: The incoming line is frozern but I need to change it.
      uf_line = line.gsub(/\(|\)|,/, '')
      parts = uf_line.split(' contains ')

      food = Food.new

      parts.first.split.each do |ingredient|
        food.add_ingredient ingredient
      end

      parts.last.split.each do |allergen|
        food.add_allegen allergen
      end

      foods << food
    end
  end
end

class Food
  attr_accessor :allergens, :ingredients

  def initialize
    self.allergens = []
    self.ingredients = []
  end

  def add_allegen input
    allergens << input
  end

  def add_ingredient input
    ingredients << input
  end

  def allergen? input
    allergens.include? input
  end

  def ingredient? input
    ingredients.include? input
  end
end

class FoodDb
  def initialize food_stuffs
    self.food_stuffs = food_stuffs
  end

  def dangerous_ingredients
    @dangerous_ingredients || find_dangerous_ingredients
  end

  def non_allergen_ingredients
    @non_allergen_ingredients ||= find_non_allergen_ingredients
  end

  private

  attr_accessor :food_stuffs

  def allergens
    @allergens ||= food_stuffs.map(&:allergens).flatten.sort.uniq
  end

  def translated_allergens
    @translated_allergens ||= translate_allergens
  end

  def matched_allergens
    @matched_allergens ||= match_allergens
  end

  # NOTE: Return list of ingredients that represent the allergens.
  # Again, we can read allergens, we can not read ingredients.
  def translate_allergens
    potential_allergen_ingredients.map(&:last).flatten.sort.uniq
  end

  # Return an Array of 2-element arrays where the first element
  # is the 'allergen', and the second element is a list of possible
  # ingredients.
  def potential_allergen_ingredients
    allergens.map { [_1, find_allergen_ingredients(_1)] }
  end

  def find_allergen_ingredients allergen
    ingredient_sets = food_stuffs.select { _1.allergen? allergen }.map(&:ingredients)
    ingredient_sets.inject do |all_sets, ingredient_set|
      # NOTE: Find Set Intersection between accumulated sets and an
      # individual ingredient set. This produces unique values between
      # the sets.
      all_sets.sort & ingredient_set.sort
    end
  end

  def find_non_allergen_ingredients
    ingredient_sets = food_stuffs.map(&:ingredients)
    ingredient_sets.inject([]) { |sum, ingredient_set| sum + (ingredient_set - translated_allergens) }
  end

  # NOTE: Return a hash of 'allergen' => 'ingredient'
  # Do this by systematically going through the list of potential
  # allergen ingredients, removing matched allergens until there
  # are no more to process.
  def match_allergens
    matched = {}
    dangerous = potential_allergen_ingredients
    until dangerous.empty?
      # NOTE: Find a single-item ingredient list
      allergen, ingredient = dangerous.find { _2.size == 1 }
      matched[allergen] = ingredient.first

      # NOTE: Now remove the matched ingredient; this removes the
      # matched ingredient from the other ingredient lists.
      dangerous = dangerous.map { [_1, _2 - ingredient] }

      # NOTE: Now remove the matched allergen
      dangerous = dangerous.reject { _1.first == allergen }
    end
    matched
  end

  def find_dangerous_ingredients
    matched_allergens.to_a.sort_by(&:first).map(&:last)
  end
end

class FoodInspector
  def initialize food_stuffs
    self.food_db = FoodDb.new food_stuffs
  end

  def dangerous_ingredient_list
    food_db.dangerous_ingredients.join(',')
  end

  def non_allergen_ingredients
    food_db.non_allergen_ingredients
  end

  private

  attr_accessor :food_db
end
