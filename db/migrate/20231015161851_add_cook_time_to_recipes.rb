class AddCookTimeToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :cook_time, :integer
  end
end
