require 'rails_helper'

RSpec.describe Item, type: :model do
  it {should validate_presence_of(:name).on(:create)}
  it {should have_many(:recipes)}

  it 'should not create an item if it exists' do
    2.times { Item.create(:name => 'Egg') }
    expect(Item.count).to eq(1)
  end

  it 'should ignore case when creating items' do
    Item.create(:name => 'Egg')
    Item.create(:name => 'egg')
    expect(Item.count).to eq(1)
  end
end
