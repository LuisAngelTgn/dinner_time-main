class AddIndexToExactNameInIngredients < ActiveRecord::Migration[7.0]
  def change
    add_index :ingredients, :exact_name
  end
end
