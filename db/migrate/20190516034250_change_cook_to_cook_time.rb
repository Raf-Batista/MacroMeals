class ChangeCookToCookTime < ActiveRecord::Migration[5.2]
  def change
    rename_column :recipes, :cook, :cook_time
  end
end
