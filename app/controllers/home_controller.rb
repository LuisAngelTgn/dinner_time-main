class HomeController < ApplicationController
  def index
    @recipes = Recipe.all
    @recipes_images = Recipe.limit(10).pluck(:image)
  end
end
