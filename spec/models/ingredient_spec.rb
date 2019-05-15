require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  it {should belong_to(:recipe)}
  it {should belong_to(:item)}
  it do
    should validate_presence_of(:quantity).
      with_message("is not a number")
  end
  it 'should not have quantity less than one' do
    ingredient = Ingredient.new(:quantity => 0)
    ingredient.recipe = Recipe.new(:name => 'Test', :directions => 'Test')
    ingredient.item = Item.new(:name => 'Test')
    expect(ingredient.valid?).to eq(false)
  end
  it do
    should validate_presence_of(:metric).
      with_message("Metric must be either gram, cup, or oz")
  end

end
