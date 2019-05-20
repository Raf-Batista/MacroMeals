# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

keto_king = User.create(:username => 'Keto_king', :password => 'keto123')
keto_king.recipes.build(:name => 'Bacon and Eggs', :directions => 'Cook some bacon and eggs', :prep_time => 5, :cook_time => 10, :protien => 30, :carbs => 0, :fat => 20)
bacon = Item.create(:name => 'Bacon')
egg = Item.create(:name => 'Egg')
keto_king.recipes.last.ingredients.build(item_id: bacon.id, quantity: '4 strips')
keto_king.recipes.last.ingredients.build(item_id: egg.id, quantity: '4')
keto_king.save

carbs4days = User.create(:username => 'carbs4days', :password => 'carbs123')
carbs4days.recipes.build(:name => 'Granola Bowl', :directions => 'Put the ingredients together, mix, enjoy. Best before a heavy squat or deadlift session', :prep_time => 5, :cook_time => 2, :protien => 15, :carbs => 50, :fat => 15)
granola = Item.create(:name => 'Granola')
blueberry = Item.create(:name => 'Blueberry')
yogurt = Item.create(:name => 'Yogurt')
blackberry = Item.create(:name => 'Blackberry')
carbs4days.recipes.last.ingredients.build(item_id: granola.id, quantity: '24 grams')
carbs4days.recipes.last.ingredients.build(item_id: blueberry.id, quantity: '12 grams')
carbs4days.recipes.last.ingredients.build(item_id: blackberry.id, quantity: '12 grams')
carbs4days.recipes.last.ingredients.build(item_id: yogurt.id, quantity: '200 grams')
carbs4days.save

gains_bro = User.create(:username => 'gains_bro', :password => 'gains123')
gains_bro.recipes.build(:name => 'Bodybuilding Meal', :directions => "Cook the rice chicke and brocolli. No sauces bro, it's not bulking season", :prep_time => 15, :cook_time => 25, :protien => 50, :carbs => 70, :fat => 10)
chicken = Item.create(:name => 'Chicken')
rice = Item.create(:name => 'Rice')
brocolli = Item.create(:name => 'Brocolli')
gains_bro.recipes.last.ingredients.build(item_id: chicken.id, quantity: '200 grams')
gains_bro.recipes.last.ingredients.build(item_id: rice.id, quantity: '250 grams')
gains_bro.recipes.last.ingredients.build(item_id: brocolli.id, quantity: '200 grams')
gains_bro.save



another_user = User.create(:username => 'another_user', :password => 'user123')
another_user.recipe_ratings.build(recipe_id: keto_king.recipes.last.id, rating: 4)
user = User.create(username: 'test_username', password: 'test123')
user.recipe_ratings.build(recipe_id: Recipe.last.id, rating: 3)
user.save
another_user.save
