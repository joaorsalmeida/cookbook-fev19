class Api::V1::RecipesController < Api::V1::ApplicationController
  def index
    @recipes = Recipe.all
    render status: 200, json: @recipes
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    render status: 200, json: 'Recipe deleted'
  end
end
