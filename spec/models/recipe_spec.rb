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

  it {should have_many(:items)}

  it {should have_many(:recipe_ratings)}

end
