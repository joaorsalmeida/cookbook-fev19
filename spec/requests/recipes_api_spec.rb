require 'rails_helper'

RSpec.describe "Recipes API", type: :request do
  describe "list recipes" do
    it 'should list all recipes' do
      recipe = create_recipe('Feijoada')
      other_recipe = create_recipe('Macarronada')

      # chamada para a API
      get '/api/v1/recipes'

      # expectativas
      result = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(result.count).to eq 2

      expect(result.first['title']).to eq 'Feijoada'
      expect(result.last['title']).to eq 'Macarronada'

      recipe_1 = Recipe.new(result.first)
      expect(recipe_1.title).to eq 'Feijoada'

      #expect(response).to have_http_status(:success)
      expect(response.body).to include 'Feijoada'
      expect(response.body).to include 'Macarronada'
    end

    it 'delete a recipe' do
      create_recipe('Feijoada')

      delete '/api/v1/recipes/1'

      expect(response.status).to eq 200
    end

    it 'delete a recipe that does not exist' do
      delete '/api/v1/recipes/999'

      expect(response.status).to eq 404
      expect(response.body).to include 'Record not found'
    end
  end
end


def create_recipe(title)
  recipe_type = RecipeType.create(name: 'Sobremesa')
  recipe = Recipe.create(title: title, recipe_type: recipe_type,
                         cuisine: 'Brasileira', difficulty: 'Médio',
                         cook_time: 60,
                         ingredients: 'Farinha, açucar, cenoura',
                         cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')


end
