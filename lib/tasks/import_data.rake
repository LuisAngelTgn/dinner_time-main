# lib/tasks/import_data.rake

namespace :db do
  desc "Import data from JSON file"
  task import_data: :environment do
    file_path = 'public/recipes-en.json'
    data = JSON.parse(File.read(file_path))

    data.each do |item|
      recipe = Recipe.find_by(title: item['title'])

      if recipe

        recipe.update(image: item['image'])
      else

        recipe = Recipe.create!(
          title: item['title'],
          description: item['description'],
          image: item['image']
        )
      end

     
      if item['ingredients'].present?
        ingredients = item['ingredients'].map do |ingredient_name|
          Ingredient.find_or_create_by(name: ingredient_name)
        end


        recipe.ingredients << ingredients
      end
    end

    puts "Data imported successfully."
  end
end
