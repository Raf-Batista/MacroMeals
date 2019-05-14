class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :name
      t.integer :prep
      t.integer :cook
      t.integer :servings
      t.integer :protien
      t.integer :carbs
      t.integer :fat
      t.text :directions
      t.timestamps
    end
  end
end
