class IngredientsController < ApplicationController
  def index
    # @ingredients = Ingredient.all.order('exact_name ASC').uniq
    @ingredients = Ingredient.limit(10000)
    @ingredients = @ingredients.uniq { |ingredient| ingredient.exact_name }
  end



end
