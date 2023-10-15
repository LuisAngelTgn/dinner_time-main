class AddExactNameToIngredients < ActiveRecord::Migration[6.0]
  def change
    add_column :ingredients, :exact_name, :string

    # Copia los nombres de ingredientes sin cantidades a la nueva columna
    Ingredient.all.each do |ingredient|
      exact_name = ingredient.name.gsub(/^\d+\s+/, '') # Elimina la cantidad al principio
      exact_name = exact_name.gsub(/\b(?:cup|cups)\b/i, '') # Elimina "cup" o "cups" (ignora mayúsculas/minúsculas)
      exact_name = exact_name.gsub(/½/, '') # Elimina la fracción ½
      exact_name = exact_name.gsub(/\(15 ounce\)/i, '') # Elimina "(15 ounce)" (ignora mayúsculas/minúsculas)
      exact_name = exact_name.gsub(/¼/, '') # Elimina la fracción ¼
      ingredient.update(exact_name: exact_name.strip) # Elimina espacios en blanco adicionales
    end
  end
end

Ingredient.all.each do |ingredient|
  exact_name = exact_name.gsub(/⅔/, '')
  exact_name = exact_name.gsub(/\(12 fluid ounce\)/i, '')
  ingredient.update(exact_name: exact_name.strip) # Elimina espacios en blanco adicionales
end

Ingredient.all.each do |ingredient|
  exact_name = ingredient.exact_name.gsub(/¾/, '').gsub(/\(12 fluid ounce\)/i, '')
  ingredient.update(exact_name: exact_name.strip) # Elimina espacios en blanco adicionales
end

Ingredient.all.each do |ingredient|
  exact_name = ingredient.exact_name.gsub(/\(20 ounce\)/i, '').gsub(/\(24 ounce\)/i, '').gsub(/\(28 ounce\)/i, '').gsub(/\(29 ounce\)/i, '').gsub(/\(30 ounce\)/i, '').gsub(/\(32 ounce\)/i, '').gsub(/\(4 ounce\)/i, '').gsub(/\(6 ounce\)/i, '').gsub(/\(7.6 ounce\)/i, '').gsub(/\(9 ounce\)/i, '')
  ingredient.update(exact_name: exact_name.strip) # Elimina espacios en blanco adicionales
end



