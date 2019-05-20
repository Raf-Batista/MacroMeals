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

  context "User's show page" do

    it "Displays a User's info without recipes" do
      user = User.create(:username => 'test', :password => 'test123')
      page.set_rack_session(:user_id => user.id)
      visit user_path(user)
      expect(page).to have_content('Hello test, you currently have no recipes. Click Create Recipe to create your macro friendly recipe')
    end

    it "Displays a User's info with recipes" do
      user = User.create(:username => 'test', :password => 'test123')
      page.set_rack_session(:user_id => user.id)
      user.recipes.build(:name => 'Recipe 1', :directions => 'directions').save
      visit user_path(user)
      expect(page).to have_content('Hello test, here are your current recipes')
    end

    it "Should link to a recipe's show page" do
      user = User.create(:username => 'test', :password => 'test123')
      page.set_rack_session(:user_id => user.id)
      user.recipes.build(:name => 'Recipe 1', :directions => 'directions').save
      visit user_path(user)
      click_link('Recipe 1')
    end

    it 'Should redirect to login if not logged in' do
      user = User.create(:username => 'test', :password => 'test123')
      visit user_path(user)
      expect(page.current_path).to eq(login_path)
      expect(page).to have_content('You are not logged in')
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
      expect(page).to have_content('The password you entered was incorrect')
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
      find(:xpath, "/html/body/nav/ul/li[3]/a").click()
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

  context 'Edit a User' do
    it 'Can edit a User Successfully' do
      user = User.create(:username => 'test', :password => 'test123')
      page.set_rack_session(:user_id => user.id)
      visit edit_user_path(user)
      fill_in 'user[username]', :with => 'updated username'
      fill_in 'user[password]', :with => 'test123'
      click_button 'Update'
      expect(User.last.username).to eq('updated username')
    end

    # it 'Can not edit a User with blank or incorrect password confirmation' do
    #   user = User.create(:username => 'test', :password => 'test123')
    #   page.set_rack_session(:user_id => user.id)
    #   visit edit_user_path(user)
    #   fill_in 'username', :with => 'updated username'
    #   fill_in 'password_confirmation', :with => ''
    #   click_button 'Update'
    #   expect(page.current_path).to eq(edit_user_path(user))
    #   expect(page).to have_content('Enter your password to confirm your changes')
    # end

    it 'Can not edit a different User' do
      user = User.create(:username => 'test', :password => 'test123')
      a_different_user = User.create(:username => 'a different user', :password => 'abc123')
      page.set_rack_session(:user_id => user.id)

      visit edit_user_path(a_different_user)
      expect(page.current_path).to eq(user_path(user))
      expect(page).to have_content('Please login to edit your account')
    end

    it 'redirects_to login_path if not logged in' do
      user = User.create(:username => 'test', :password => 'test123')
      visit edit_user_path(user)
      expect(page.current_path).to eq(login_path)
      expect(page).to have_content('Please login to edit your account')
    end
  end

  context 'Creating recipes' do
    it 'Successfully creates a recipe' do
      user = User.create(:username => 'test', :password => 'test123')
      page.set_rack_session(:user_id => user.id)
      visit new_user_recipe_path(user)
      fill_in 'recipe[name]', :with => 'Test Recipe'
      fill_in 'recipe[directions]', :with => 'Test Directions'
      click_button 'Create Recipe'
      expect(Recipe.count).to eq(1)
    end

    it 'renders new with error messages' do
      user = User.create(:username => 'test', :password => 'test123')
      page.set_rack_session(:user_id => user.id)
      visit new_user_recipe_path(user)
      fill_in 'recipe[name]', :with => ''
      fill_in 'recipe[directions]', :with => ''
      click_button 'Create Recipe'
      expect(page).to have_content("Name can't be blank, Directions can't be blank")
    end

    it 'Redirects to login if not logged in' do
      User.create(:username => 'test', :password => 'test123')
      page.set_rack_session(:user_id => nil)
      visit 'users/1/recipes/new'
      expect(page.current_path).to eq(login_path)
    end

    it 'Displays a message when a user tries to create a recipe while not logged in' do
      visit 'users/1/recipes/new'
      expect(page).to have_content('You can not create a recipe, please sign up or login')
    end

    it 'redirects to ingredients new after creating a recipe' do
      user = User.create(:username => 'test', :password => 'test123')
      page.set_rack_session(:user_id => user.id)
      visit new_user_recipe_path(user)
      fill_in 'recipe[name]', :with => 'Test Recipe'
      fill_in 'recipe[directions]', :with => 'Test Directions'
      click_button 'Create Recipe'
      expect(page.current_path).to eq(new_recipe_ingredient_path(user.recipes.last))
    end

    it 'can create ingredients' do
      user = User.create(:username => 'test', :password => 'test123')
      user.recipes.build(:name => 'test', :directions => 'directions').save
      page.set_rack_session(:user_id => user.id)
      visit new_recipe_ingredient_path(user.recipes.last)
      fill_in 'ingredient[item]', :with => 'item'
      fill_in 'ingredient[quantity]', :with => '2'
      click_button 'Create Ingredients'
      expect(Ingredient.count).to eq(1)
    end

    it 'can not create item with numbers or special characters' do
      expect(Item.create(:name => 1).valid?).to eq(false)
    end

    it 'redirects to new ingredient if user clicks yes' do
      user = User.create(:username => 'test', :password => 'test123')
      user.recipes.build(:name => 'test', :directions => 'directions').save
      page.set_rack_session(:user_id => user.id)
      visit new_recipe_ingredient_path(user.recipes.last)
      fill_in 'ingredient[item]', :with => 'item 1'
      fill_in 'ingredient[quantity]', :with => '2'
      choose 'add_true'
      click_button 'Create Ingredients'
      expect(page.current_path).to eq(new_recipe_ingredient_path(user.recipes.last))
    end

    it 'redirects to new user recipe if user clicks no' do
      user = User.create(:username => 'test', :password => 'test123')
      user.recipes.build(:name => 'test', :directions => 'directions').save
      page.set_rack_session(:user_id => user.id)
      visit new_recipe_ingredient_path(user.recipes.last)
      fill_in 'ingredient[item]', :with => 'item 1'
      fill_in 'ingredient[quantity]', :with => '2'
      choose 'add_false'
      click_button 'Create Ingredients'
      expect(page.current_path).to eq(user_recipe_path(user, user.recipes.last))
    end

    it "shows all of a user's ingredients when adding ingredients to a recipe" do
      user = User.create(:username => 'test', :password => 'test123')
      user.recipes.build(:name => 'test', :directions => 'directions').save
      page.set_rack_session(:user_id => user.id)
      item1 = Item.create(:name => 'one')
      item2 = Item.create(:name => 'two')
      Ingredient.create(:item_id => item1.id, :recipe_id => user.recipes.last.id, :quantity => 2)
      Ingredient.create(:item_id => item2.id, :recipe_id => user.recipes.last.id, :quantity => 3)
      visit new_recipe_ingredient_path(user.recipes.last)
      expect(page).to have_content('one')
      expect(page).to have_content('two')
    end

  end

  context 'Viewing recipes' do
    it 'shows a single recipe' do
      user = User.create(:username => 'test', :password => 'test123')
      user.recipes.build(:name => 'test', :directions => 'directions').save
      page.set_rack_session(:user_id => user.id)
      visit recipe_path(user.recipes.last)
      expect(page).to have_content('test')
      expect(page).to have_content('directions')
    end

    it 'redirects to login if not logged in' do
      user = User.create(:username => 'test', :password => 'test123')
      user.recipes.build(:name => 'test', :directions => 'directions').save
      visit recipe_path(user.recipes.last)
      expect(page).to have_content('You are not logged in')
      expect(page.current_path).to eq(login_path)
    end

    it "Shows a recipe's ingredients" do
      user = User.create(:username => 'test', :password => 'test123')
      user.recipes.build(:name => 'test', :directions => 'directions').save
      page.set_rack_session(:user_id => user.id)
      item1 = Item.create(:name => 'Bacon')
      item2 = Item.create(:name => 'Egg')
      Ingredient.create(:recipe_id => user.recipes.last.id, :item_id => item1.id, :quantity => 4)
      Ingredient.create(:recipe_id => user.recipes.last.id, :item_id => item2.id, :quantity => 5)
      visit recipe_path(user.recipes.last)
      expect(page).to have_content('Bacon')
      expect(page).to have_content('Egg')
      expect(page).to have_content('4')
      expect(page).to have_content('5')
    end

    it "Shows a recipe's macros" do
      user = User.create(:username => 'test', :password => 'test123')
      user.recipes.build(:name => 'test', :directions => 'directions', :protien => 35, :carbs => 0, :fat => 20).save
      page.set_rack_session(:user_id => user.id)
      item1 = Item.create(:name => 'Bacon')
      item2 = Item.create(:name => 'Egg')
      Ingredient.create(:recipe_id => user.recipes.last.id, :item_id => item1.id, :quantity => 4)
      Ingredient.create(:recipe_id => user.recipes.last.id, :item_id => item2.id, :quantity => 5)
      visit recipe_path(user.recipes.last)
      expect(page).to have_content('protien: 35g carbs: 0g fat: 20g')
    end

    it "Shows a recipe's prep and cook time" do
      user = User.create(:username => 'test', :password => 'test123')
      user.recipes.build(:name => 'test', :directions => 'directions', :cook_time => 25, :prep_time => 15).save
      page.set_rack_session(:user_id => user.id)
      visit recipe_path(user.recipes.last)
      expect(page).to have_content('Prep time: 15')
      expect(page).to have_content('Cook time: 25')
    end

    it "Display a recipe's owner" do
      user = User.create(:username => 'username', :password => 'test123')
      user.recipes.build(:name => 'test', :directions => 'directions').save
      page.set_rack_session(:user_id => user.id)
      item1 = Item.create(:name => 'Bacon')
      item2 = Item.create(:name => 'Egg')
      Ingredient.create(:recipe_id => user.recipes.last.id, :item_id => item1.id, :quantity => 4)
      Ingredient.create(:recipe_id => user.recipes.last.id, :item_id => item2.id, :quantity => 5)
      visit recipe_path(user.recipes.last)
      expect(page).to have_content(user.username)
    end

    it 'Shows all Recipes' do
      user = User.create(:username => 'test', :password => 'test123')
      3.times do |i|
        user.recipes.build(:name => "Recipe #{i}", :directions => 'directions', :protien => 25, :carbs => 20, :fat => 5).save
      end
      visit recipes_path
      expect(page).to have_content('Recipe 0')
      expect(page).to have_content('Recipe 1')
      expect(page).to have_content('Recipe 2')
      expect(page).to have_content('protien: 25g carbs: 20g fat: 5g')
    end

    it "Shows all of a user's recipes" do
      user = User.create(:username => 'test', :password => 'test123')
      2.times do |i|
        user.recipes.build(:name => "User Recipe #{i}", :directions => 'directions').save
      end
      page.set_rack_session(:user_id => user.id)
      visit user_recipes_path(user)
      click_link 'User Recipe 1'
    end

    it 'Shows Recipes with 10 minutes or less cook time' do
      user = User.create(:username => 'test', :password => 'test123')
      3.times do |i|
        user.recipes.build(:name => "User Recipe #{i}", :directions => 'directions', :cook_time => "#{i + 7}").save
      end
      a_different_user = User.create(:username => 'a different user', :password => 'test123')
      3.times do |i|
        a_different_user.recipes.build(:name => "Another User #{i}", :directions => 'directions', :cook_time => "#{i + 10}").save
      end
      visit ten_minute_meals_path
      expect(page).to have_content('Cook time: 8')
      expect(page).to have_content('Cook time: 10')
      expect(page).to have_no_content('Cook time: 11')
      expect(page).to have_no_content('Cook time: 14')
    end
  end

  context 'Edit Recipes' do
    it 'can edit a recipe owned by a user' do
      user = User.create(:username => 'test', :password => 'test123')
      user.recipes.build(:name => "Recipe 1", :directions => 'directions').save
      page.set_rack_session(:user_id => user.id)
      visit edit_user_recipe_path(user, user.recipes.last)
      fill_in 'recipe[name]', :with => 'Updated Recipe'
      fill_in 'recipe[directions]', :with => 'Updated Directions'
      click_button 'Update Recipe'
      expect(user.recipes.last.name).to eq('Updated Recipe')
      expect(user.recipes.last.directions).to eq('Updated Directions')
    end

    it 'renders edit with errors' do
      user = User.create(:username => 'test', :password => 'test123')
      user.recipes.build(:name => "Recipe 1", :directions => 'directions').save
      page.set_rack_session(:user_id => user.id)
      visit edit_user_recipe_path(user, user.recipes.last)
      fill_in 'recipe[name]', :with => ''
      fill_in 'recipe[directions]', :with => ''
      click_button 'Update Recipe'
      expect(page).to have_content("Name can't be blank, Directions can't be blank")
    end

    it 'can not edit a recipe owned by a different user' do
      user1 = User.create(:username => 'user 1', :password => 'test123')
      user1.recipes.build(:name => "User Recipe 1", :directions => 'directions').save
      user2 = User.create(:username => 'user 2', :password => 'test123')
      user2.recipes.build(:name => "User Recipe 2", :directions => 'directions').save
      page.set_rack_session(:user_id => user1.id)
      visit edit_user_recipe_path(user2, user2.recipes.last)
      expect(page.current_path).to eq(user_path(user1))
    end

    it 'sets flash message when trying to edit a recipe owned by a different user' do
      user1 = User.create(:username => 'user 1', :password => 'test123')
      user1.recipes.build(:name => "User Recipe 1", :directions => 'directions').save
      user2 = User.create(:username => 'user 2', :password => 'test123')
      user2.recipes.build(:name => "User Recipe 2", :directions => 'directions').save
      page.set_rack_session(:user_id => user1.id)
      visit edit_user_recipe_path(user2, user2.recipes.last)
      expect(page).to have_content("You can not edit another user's recipe")
    end
  end

  context 'Deleting a recipe' do
    it 'can delete a recipe' do
      user = User.create(:username => 'user 1', :password => 'test123')
      user.recipes.build(:name => "User Recipe 1", :directions => 'directions').save
      page.set_rack_session(:user_id => user.id)
      visit user_recipe_path(user, user.recipes.last)
      click_link 'Delete'
      expect(Recipe.count).to eq(0)
    end

    # it 'can not delete a recipe owned by another user' do
    #   user = User.create(:username => 'user 1', :password => 'test123')
    #   page.set_rack_session(:user_id => user.id)
    #   another_user = User.create(:username => 'another recipe', :password => 'test123')
    #   another_user.recipes.build(:name => "Recipe 1", :directions => 'directions').save
    #   visit user_recipe_path(another_user, another_user.recipes.last)
    #   click_link("Delete")
    #   expect(page).to have_content('You are not logged in')
    #   expect(page.current_path).to eq(user_path(user))
    # end
  end
end
