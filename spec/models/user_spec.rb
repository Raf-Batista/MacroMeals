require 'rails_helper'

RSpec.describe User, type: :model do
  it {should validate_presence_of(:email).on(:create)}

  it {should validate_presence_of(:username).on(:create)}

  it {should validate_presence_of(:password).on(:create)}

  it {should have_many(:recipes)}

  it {should have_many(:recipe_ratings)}

  it 'should not create a user with the same username' do
    User.create(:email => 'test@example.com', :username => 'test', :password => 'test123')
    user = User.new(:email => 'test3@example.com', :username => 'test', :password => 'test123')
    expect(user.valid?).to eq(false)
  end
end
