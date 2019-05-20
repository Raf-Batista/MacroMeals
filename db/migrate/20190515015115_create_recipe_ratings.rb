class CreateRecipeRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :recipe_ratings do |t|
      t.integer :recipe_id
      t.integer :user_id
      t.integer :rating
    end
  end
end
