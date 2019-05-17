require 'rails_helper'


RSpec.describe 'Users features', :type => :feature do
  context 'Sign Up' do
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

    it 'redirects to show page if logged in' do
      user = User.create(:username => 'test', :password => 'test123')
      page.set_rack_session(:user_id => user.id)
      visit new_user_path
      expect(page.current_path).to eq(user_path(user))
    end
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

  it 'does not log in if password is incorrect' do
    User.create(:username => 'test', :password => 'test123')
    visit login_path
    fill_in 'username', :with => 'test'
    fill_in 'password', :with => 'wrong_password'
    click_button 'Log In'
    expect(page).to have_content('The email or password you entered was incorrect')
    expect(page.current_path).to eq(login_path)
  end

  it 'Successfully logs out' do
    visit login_path
    fill_in 'username', :with => 'test'
    fill_in 'password', :with => 'test123'
    click_button 'Log In'
    click_on 'Logout'
    expect(page.get_rack_session['user_id']).to eq(nil)
  end
  it 'Displays logout message' do
    visit login_path
    fill_in 'username', :with => 'test'
    fill_in 'password', :with => 'test123'
    click_button 'Log In'
    click_on 'Logout'
    expect(page).to have_content('Logout Successful')
  end

end
