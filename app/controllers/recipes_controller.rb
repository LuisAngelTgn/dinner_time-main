class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
  end
  def search
    if params[:ingredients].present?
      selected_ingredient_ids = params[:ingredients]
      @recipes = Recipe.joins(:ingredients)
                       .where('ingredients.id IN (?)', selected_ingredient_ids)
                       .group('recipes.id')
                       .having("COUNT(DISTINCT ingredients.id) = ?", selected_ingredient_ids.count)
    else
      @recipes = Recipe.all
    end
    render 'results'
  end
end