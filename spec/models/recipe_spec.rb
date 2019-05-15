require 'rails_helper'

RSpec.describe Recipe, type: :model do
  it do
    should validate_presence_of(:name).
      with_message('Your Recipe needs to have a name')
  end
  it do
    should validate_presence_of(:directions).
      with_message('Your Recipe needs to have directions')
  end


  it 'should display the macros for a recipe' do
    recipe = Recipe.new(:name => 'Protien Shake', :protien => 25, :carbs => '2', :fat => 0)
    expect(recipe.macros).to eq("protien: 25g carbs: 2g fat: 0g")
  end

  it 'should return the average when #avg_rating is called' do
    User.create(:email => 'test@email.com', :username => 'test', :password => 'test123').recipes.
      build(:name => 'Recipe', :directions => 'Directions').save
    User.create(:email => 'user@email.com', :username => 'another_user', :password => 'user123').
      recipe_ratings.build(recipe_id: Recipe.last.id, rating: 4).save
    User.create(:email => 'user2@email.com', :username => 'another_user2', :password => 'user123').
      recipe_ratings.build(recipe_id: Recipe.last.id, rating: 3).save

    expect(Recipe.last.avg_rating).to eq(3.5)
  end

  it 'returns nil if a recipe has no ratings' do
    User.create(:email => 'test@email.com', :username => 'test', :password => 'test123').recipes.
      build(:name => 'Recipe', :directions => 'Directions').save
    expect(Recipe.last.avg_rating).to eq(nil)
  end

  it {should have_many(:items)}

  it {should have_many(:recipe_ratings)}

end
