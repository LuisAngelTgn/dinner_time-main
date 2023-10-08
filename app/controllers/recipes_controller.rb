class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
  end
  def search
    if params[:ingredients].present?
      selected_ingredient_ids = params[:ingredients]
      @selected_ingredients = Ingredient.where(id: selected_ingredient_ids)


      @recipes = Recipe
                   .joins(:ingredients_recipes)
                   .where('ingredients_recipes.ingredient_id IN (?)', selected_ingredient_ids)
                   .group('recipes.id')
                   .includes(:ingredients)

      @ingredients_not_included = Ingredient
                                    .where.not(id: selected_ingredient_ids)
                                    .distinct

    else
      @recipes = Recipe.all
    end
    render 'results'
  end


end