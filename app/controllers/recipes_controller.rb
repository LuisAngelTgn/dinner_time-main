class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end
  def search
    # @ingredients =  Ingredient.limit(6000)
    # @ingredients = @ingredients.uniq { |ingredient| ingredient.exact_name }

    if params[:ingredients].present?

      selected_ingredient = JSON.parse(params[:ingredients].first)

      @user_ingredients = selected_ingredient

      # Construir un patrón regex que busca al menos una coincidencia de palabras en exact_name
      regex_pattern = selected_ingredient.map { |pattern| "\\b#{Regexp.escape(pattern)}\\b" }.join("|")

      # Utilizar la función REGEXP para buscar coincidencias en exact_name
      selected_ingredients = Ingredient.where("exact_name REGEXP ?", regex_pattern)

      selected_exact_names = selected_ingredients.pluck(:exact_name)


      @related_ingredients = Ingredient.where(exact_name: selected_exact_names)
      @related_ingredients = @related_ingredients.uniq { |ingredient| ingredient.exact_name }
      related_ingredients_ids = @related_ingredients.pluck(:id)


      @recipes = Recipe
                   .joins(:ingredients_recipes)
                   .where('ingredients_recipes.ingredient_id IN (?)', related_ingredients_ids)
                   .group('recipes.id')
                   .includes(:ingredients)

      @ingredients_not_included = Ingredient
                                    .where.not(name: selected_ingredient)
                                    .distinct

      @unique_ingredients = @related_ingredients.uniq { |ingredient| ingredient.exact_name.downcase  }
      @unique_ingredients_not_included = @ingredients_not_included.uniq { |ingredient| ingredient.exact_name.downcase }



    else
      @recipes = Recipe.all
    end
    render 'results'
  end


end