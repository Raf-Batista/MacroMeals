class Recipe < ApplicationRecord
  validates :name, :presence => {:message => 'Your Recipe needs to have a name'}
  validates :directions, :presence => {:message => 'Your Recipe needs to have directions'}
  belongs_to :user
  has_many :ingredients
  has_many :items, :through => :ingredients
  has_many :recipe_ratings

  scope :ten_minute_meals, lambda { where('cook_time <= ?', 10) }
  scope :max_protien, lambda { select('MAX(protien)') }
  scope :max_carbs, lambda { select('MAX(carbs)') }
  scope :max_fat, lambda { select('MAX(fat)') }

  def macros
    "protien: #{self.protien}g carbs: #{self.carbs}g fat: #{self.fat}g"
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

end
