class Recipe < ApplicationRecord
  before_destroy :destroy_ingredients
  validates :name, :presence => true, :uniqueness => {case_sensitive: false}
  validates :directions, :presence => true
  belongs_to :user
  has_many :ingredients
  has_many :items, :through => :ingredients
  has_many :recipe_ratings

  scope :ten_minute_meals, lambda { where('cook_time <= ?', 10) }
  scope :max_protien, lambda { Recipe.order(:protien => :desc) }
  scope :max_carbs, lambda { Recipe.order(:carbs => :desc) }
  scope :max_fat, lambda { Recipe.order(:fat => :desc) }

  def macros
    "Protien: #{self.protien}g Carbs: #{self.carbs}g Fat: #{self.fat}g"
  end

  def avg_rating
    avg =  recipe_ratings.average(:rating)
    avg.to_f if avg
  end

  def self.highest_rating
    highest_rating = Hash.new
    highest_rating[:rating] = 0
    self.all.each do |recipe|
      rating = recipe.avg_rating
      if highest_rating[:rating] < rating
        highest_rating[:rating] = rating
        highest_rating[:recipe] = recipe
      end
    end
    highest_rating[:recipe]
  end

  def create_ingredients(ingredients)
    ingredients.each do |ingredient|
      new_ingredient = {}
      item = Item.find_or_create_by(:name => ingredient[:name])
      new_ingredient[:item_id] = item.id
      new_ingredient[:quantity] = ingredient[:quantity]
      self.ingredients.create(new_ingredient)
    end
  end

  private

  def destroy_ingredients
    self.ingredients.destroy_all
  end

end
