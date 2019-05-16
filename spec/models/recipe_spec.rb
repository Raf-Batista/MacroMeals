require 'rails_helper'

RSpec.describe Recipe, type: :model do
  it do
    should validate_presence_of(:name).
      with_message('Your Recipe needs to have a name')
  end

  it 'should have a unique name' do
    user = User.create(:email => 'test@email.com', :username => 'test', :password => 'test123')
    user.recipes.build(:name => 'Recipe', :directions => 'Directions').save
    expect(Recipe.create(:user_id => user.id, :name => 'Recipe', :directions => 'Directions').valid?).to eq(false)
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

  context 'scope methods' do
    it 'returns all recipes where the cook time is 10 minutes or less' do
      user = User.create(:email => 'test@email.com', :username => 'test', :password => 'test123')
      user.recipes.build(:name => 'Recipe1', :directions => 'directions', :cook_time => 15).save
      user.recipes.build(:name => 'Recipe2', :directions => 'directions', :cook_time => 10).save
      user.recipes.build(:name => 'Recipe3', :directions => 'directions', :cook_time => 8).save

      expect(Recipe.ten_minute_meals.count).to eq(2)
    end

    it 'returns recipes ordered by max protien' do
      user = User.create(:email => 'test@email.com', :username => 'test', :password => 'test123')
      user.recipes.build(:name => 'Recipe1', :directions => 'directions', :protien => 30).save
      user.recipes.build(:name => 'Recipe2', :directions => 'directions', :protien => 10).save
      user.recipes.build(:name => 'Recipe3', :directions => 'directions', :protien => 45).save
      user.recipes.build(:name => 'Recipe4', :directions => 'directions', :protien => 20).save
      user.recipes.build(:name => 'Recipe5', :directions => 'directions', :protien => 10).save

      expect(Recipe.max_protien.first).to eq(Recipe.find_by(:name => 'Recipe3'))
      expect(Recipe.max_protien[1]).to eq(Recipe.find_by(:name => 'Recipe1'))
    end
    it 'returns recipes ordered by max carbs' do
      user = User.create(:email => 'test@email.com', :username => 'test', :password => 'test123')
      user.recipes.build(:name => 'Recipe1', :directions => 'directions', :carbs => 23).save
      user.recipes.build(:name => 'Recipe2', :directions => 'directions', :carbs => 10).save
      user.recipes.build(:name => 'Recipe3', :directions => 'directions', :carbs => 45).save
      user.recipes.build(:name => 'Recipe4', :directions => 'directions', :carbs => 85).save
      user.recipes.build(:name => 'Recipe5', :directions => 'directions', :carbs => 10).save

      expect(Recipe.max_carbs.first).to eq(Recipe.find_by(:name => 'Recipe4'))
      expect(Recipe.max_carbs[1]).to eq(Recipe.find_by(:name => 'Recipe3'))
    end
    it 'returns recipes ordered by max fat' do
      user = User.create(:email => 'test@email.com', :username => 'test', :password => 'test123')
      user.recipes.build(:name => 'Recipe1', :directions => 'directions', :fat => 7).save
      user.recipes.build(:name => 'Recipe2', :directions => 'directions', :fat => 22).save
      user.recipes.build(:name => 'Recipe3', :directions => 'directions', :fat => 4).save
      user.recipes.build(:name => 'Recipe4', :directions => 'directions', :fat => 30).save
      user.recipes.build(:name => 'Recipe5', :directions => 'directions', :fat => 15).save

      expect(Recipe.max_fat.first).to eq(Recipe.find_by(:name => 'Recipe4'))
      expect(Recipe.max_fat[1]).to eq(Recipe.find_by(:name => 'Recipe2'))
    end
  end

  it {should have_many(:items)}

  it {should have_many(:recipe_ratings)}

end
