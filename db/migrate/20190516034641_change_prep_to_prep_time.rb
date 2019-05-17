class ChangePrepToPrepTime < ActiveRecord::Migration[5.2]
  def change
    rename_column :recipes, :prep, :prep_time
  end
end
