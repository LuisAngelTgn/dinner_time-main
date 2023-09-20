class IngredientsController < ApplicationController
  def index
    @ingredients = Ingredient.all
    end
  def search
    term = params[:term]
    ingredients = Ingredient.where('name LIKE ?', "%#{term}%").pluck(:id, :name)
    render json: ingredients.map { |id, name| { id: id, text: name } }
  end
end
