# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

keto_king = User.create(:email => 'keto@email.com', :username => 'Keto_king', :password => 'keto123')
keto_king.recipes.build(:name => 'Bacon and Eggs', :directions => 'Cook some bacon and eggs')
bacon = Item.create(:name => 'Bacon')
egg = Item.create(:name => 'Egg')
keto_king.recipes.last.ingredients.build(item_id: bacon.id, quantity: 4)
keto_king.recipes.last.ingredients.build(item_id: egg.id, quantity: 4)
keto_king.save



another_user = User.create(:email => 'user@email.com', :username => 'another_user', :password => 'user123')
another_user.recipe_ratings.build(recipe_id: keto_king.recipes.last.id, rating: 4)
another_user.save
