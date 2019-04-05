class CommentsController < ApplicationController
  def new
    
    @comment = Comment.new
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe.comments.create(comment_params)
  end
end
