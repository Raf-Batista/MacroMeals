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
      expect(page.current_path).to eq("/users/#{User.last.id}")
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
    it 'displays messsage if logged in' do
      user = User.create(:username => 'test', :password => 'test123')
      page.set_rack_session(:user_id => user.id)
      visit new_user_path
      expect(page).to have_content('You are already logged in')
    end
  end

  context 'Login' do
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

    it 'redirects to show page if logged in' do
      user = User.create(:username => 'test', :password => 'test123')
      page.set_rack_session(:user_id => user.id)
      visit login_path
      expect(page.current_path).to eq(user_path(user))
    end

    it 'displays messsage if logged in' do
      user = User.create(:username => 'test', :password => 'test123')
      page.set_rack_session(:user_id => user.id)
      visit login_path
      expect(page).to have_content('You are already logged in')
    end
  end

  context 'Log out' do
    it 'Successfully logs out' do
      visit login_path
      fill_in 'username', :with => 'test'
      fill_in 'password', :with => 'test123'
      click_button 'Log In'
      click_on 'Logout'
      expect(page.get_rack_session['user_id']).to eq(nil)
    end
    it 'Displays logout message' do
      user = User.create(:username => 'test', :password => 'test123')
      page.set_rack_session(:user_id => user.id)
      visit logout_path
      expect(page).to have_content('Logout Successful')
    end

    it 'displays message if logged out' do
      visit logout_path
      expect(page).to have_content('Can not log out, you are not logged in')
    end
  end

  context 'Creating recipes' do
    it 'Successfully creates a recipe' do
      user = User.create(:username => 'test', :password => 'test123')
      page.set_rack_session(:user_id => user.id)
      visit new_user_recipe_path(user)
      fill_in 'recipe[name]', :with => 'Test Recipe'
      fill_in 'recipe[directions]', :with => 'Test Directions'
      fill_in 'ingredient1', :with => 'Ingredient 1'
      fill_in 'quantity1', :with => '1'
      fill_in 'ingredient2', :with => 'Ingredient 2'
      fill_in 'quantity2', :with => '2'
      click_button 'Create Recipe'
      expect(Recipe.count).to eq(1)
    end

    it 'Successfully creates a recipe with ingredients' do
      user = User.create(:username => 'test', :password => 'test123')
      page.set_rack_session(:user_id => user.id)
      visit new_user_recipe_path(user)
      fill_in 'recipe[name]', :with => 'Test Recipe'
      fill_in 'recipe[directions]', :with => 'Test Directions'
      fill_in 'ingredient1', :with => 'Ingredient 1'
      fill_in 'quantity1', :with => 1
      fill_in 'ingredient2', :with => 'Ingredient 2'
      fill_in 'quantity2', :with => 2
      click_button 'Create Recipe'
      expect(Ingredient.count).to eq(2)
    end
  end

  context 'Viewing a single Recipe' do
    it 'can view a recipe' do
        user = User.create(:username => 'test', :password => 'test123')
        user.recipes.build(:name => 'test', :directions => 'directions').save
        page.set_rack_session(:user_id => user.id)
        visit recipe_path(user.recipes.last)
        expect(page).to have_content('test')
        expect(page).to have_content('directions')
    end
  end

  context 'Viewing All Recipes' do
    it 'Shows all Recipes' do
      user = User.create(:username => 'test', :password => 'test123')
      3.times do |i|
        user.recipes.build(:name => "Recipe #{i}", :directions => 'directions').save
      end
      visit recipes_path
      expect(page).to have_content('Recipe 0')
      expect(page).to have_content('Recipe 1')
      expect(page).to have_content('Recipe 2')
    end
  end

  context 'Edit Recipes' do

  end

end
