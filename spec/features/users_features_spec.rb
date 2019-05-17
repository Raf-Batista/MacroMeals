require 'rails_helper'


RSpec.describe 'Users features', :type => :feature do
  it 'signs up sucessfully' do
    visit new_user_path
    fill_in 'user[username]', :with => 'test'
    fill_in 'user[password]', :with => 'test123'
    click_button 'Sign Up'
    expect(User.last.username).to eq('test')
    expect(page).to have_content('Signed Up Successfully')
  end

  it 'adds a session hash on Sign Up' do
    visit new_user_path
    fill_in 'user[username]', :with => 'test'
    fill_in 'user[password]', :with => 'test123'
    click_button 'Sign Up'
    expect(page.get_rack_session['user_id']).to_not eq(nil)
  end

end
