class IngredientsController < ApplicationController
  def index
    @ingredients = Ingredient.all.limit(4000)
    end

end
