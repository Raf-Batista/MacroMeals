class ChangePrepToPrepTime < ActiveRecord::Migration[5.2]
  def change
    change_column :recipes, :prep, :prep_time
  end
end
