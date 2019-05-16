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

  context '#avg_rating' do

    it 'should return the average' do
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

  end

  context '.highest_rating' do
    it 'should return the recipe with the highest average rating' do
      User.create(:email => 'test@email.com', :username => 'test', :password => 'test123').recipes.
        build(:name => 'Recipe', :directions => 'Directions').save
      User.create(:email => 'user@email.com', :username => 'another_user', :password => 'user123').
        recipe_ratings.build(recipe_id: Recipe.last.id, rating: 4).save
      User.create(:email => 'user2@email.com', :username => 'another_user2', :password => 'user123').
        recipe_ratings.build(recipe_id: Recipe.last.id, rating: 3).save

      User.create(:email => 'test2@email.com', :username => 'test', :password => 'test123').recipes.
        build(:name => 'Recipe2', :directions => 'Directions').save
      User.create(:email => 'user3@email.com', :username => 'another_user3', :password => 'user123').
        recipe_ratings.build(recipe_id: Recipe.last.id, rating: 5).save
      User.create(:email => 'user4@email.com', :username => 'another_user4', :password => 'user123').
        recipe_ratings.build(recipe_id: Recipe.last.id, rating: 5).save

        expect(Recipe.highest_rating).to eq(Recipe.last)
    end
  end




  it {should have_many(:items)}

  it {should have_many(:recipe_ratings)}

end
