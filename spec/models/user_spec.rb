require 'rails_helper'

RSpec.describe User, type: :model do
  it {should validate_presence_of(:email).on(:create)}

  it {should validate_presence_of(:username).on(:create)}

  it {should validate_presence_of(:password).on(:create)}

  it {should have_many(:recipes)}

  it {should have_many(:recipe_ratings)}
end
