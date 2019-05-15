require 'rails_helper'

RSpec.describe RecipeRating, type: :model do

  it 'should not have a rating less than 1' do
    rating = RecipeRating.new(:rating => 0)
    rating.recipe = Recipe.new(:name => 'test', :directions => 'test')
    rating.user = User.new(:email => 'test@email.com', :username => 'test', :password => 'test123')
    expect(rating.valid?).to eq(false)
  end
  it 'should not have a greater than 5' do

  end

end
