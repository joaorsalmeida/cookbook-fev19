require 'rails_helper'

RSpec.describe RecipesMailer do

  describe '.notify_new_recipe' do
    it 'should send a mail to admin' do

      recipe_type = RecipeType.create(name: 'Entrada')

      recipe = Recipe.create(title: 'Bolodecenoura', difficulty: 'Médio',
                    recipe_type: recipe_type, cuisine: 'Brasileira',
                    cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

      mail = RecipesMailer.notify_new_recipe(recipe.id)



      expect(mail.to).to include('admin@cookbook.com.br')
      expect(mail.body).to include("Nova receita cadastrada")
      expect(mail.body).to include("receita cadastrada")
      expect(mail.subject).to eq("Nova receita cadastrada: #{recipe.title}")
    end

    it 'should have the correct subject' do
      recipe_type = RecipeType.create(name: 'Entrada')
      recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                    recipe_type: recipe_type, cuisine: 'Brasileira',
                    cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

      mail = RecipesMailer.notify_new_recipe(recipe.id)
 
      expect(mail.subject).to eq("Nova receita cadastrada: #{recipe.title}")
    end

    it 'should have the recipe on the body' do
      recipe_type = RecipeType.create(name: 'Entrada')
      recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                    recipe_type: recipe_type, cuisine: 'Brasileira',
                    cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

      mail = RecipesMailer.notify_new_recipe(recipe.id)
 
    end

  end

end
