require 'rails_helper'


RSpec.describe 'Users features', :type => :feature do
  it 'signs up sucessfully' do
    visit new_user_path
    fill_in 'user[username]', :with => 'test'
    fill_in 'user[password]', :with => 'test123'
    click_button 'Sign Up'
    expect(User.last.username).to eq('test')
    expect(page).to have_content('Signed Up Successfully')
    expect(page.current_path).to eq('/users/1')
  end

  it 'adds a session hash on Sign Up' do
    visit new_user_path
    fill_in 'user[username]', :with => 'test'
    fill_in 'user[password]', :with => 'test123'
    click_button 'Sign Up'
    expect(page.get_rack_session['user_id']).to_not eq(nil)
  end

  it 'logs in Successfully' do
    User.create(:username => 'test', :password => 'test123')
    visit login_path
    fill_in 'username', :with => 'test'
    fill_in 'password', :with => 'test123'
    click_button 'Log In'
    expect(page).to have_content('Log in Successful')
    expect(page.current_path).to eq('/users/1')
  end

end
