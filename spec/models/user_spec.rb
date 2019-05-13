require 'rails_helper'

RSpec.describe 'User, model', type: :model do
  it 'has valid attributes' do
    expect(User.new(:email => 'test@example.com', :username => 'test', :password => 'test123').valid?).to eq (true)
  end

  it 'is invalid without an email' do
    expect(User.new(:username => 'test', :password => 'test123').valid?).to eq (false)
  end

  it 'is invalid without a username' do
    expect(User.new(:email => 'test@example.com', :password => 'test123').valid?).to eq (false)

  end

  it 'is invalid without a password' do
    expect(User.new(:email => 'test@example.com', :username => 'test').valid?).to eq (false)
  end
end
