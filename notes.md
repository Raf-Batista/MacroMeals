A Recipe Manager - Should provide the ability to browse recipes by different filters such as date created, ingredient count, rating, comments, whatever your domain provides. Additionally ingredients would need to be unique so that the first user that adds Chicken to their recipe would create the canonical (or atomic/unique/individual) instance of Chicken (the only row to ever have the name Chicken in the ingredients table). This will force a join model between ingredients and recipes and provide an easy way to group recipes by ingredients, which would be a great view to implement. Associating some user-centric data regarding recipes such as ratings or comments would further fill out the domain and provide some great learning experiences.

Users :has_many_recipes
:username :password :password_digest

Recipes :belongs_to :user, :has_many :items through: :ingredients 
:name :prep_time :cook_time :servings

Items :recipe_id :item_ id :quantity

Ingredients 
has_many :recipes through: :items
:name :protien :carbohydtates :fat

Low Carb Pasta 5 minutes prep 15 minute cook time 2 servings 

mushroom pasta chicken 

low carb pasta mushroom pasta 2 pacages   1 1 200 grams 
low carb pasta chicken  300 grams         1 2 300 grams   

1. Write tests for models 
2. write models