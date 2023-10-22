class AddRatingsToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :ratings, :float
  end
end
