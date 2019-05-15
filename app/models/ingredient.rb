class Ingredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :item
  validates :quantity, :numericality => { :greater_than => 0 }
  validates :metric, :inclusion => {:in => %w(gram cup oz), :message => "Metric must be either gram, cup, or oz"}, :allow_blank => true
end
