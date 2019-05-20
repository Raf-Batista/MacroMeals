class AddMetricToIngredients < ActiveRecord::Migration[5.2]
  def change
    add_column :ingredients, :metric, :string
  end
end
