require 'rails_helper'

feature 'User register recipe' do
  scenario 'successfully' do
    #cria os dados necessários, nesse caso não vamos criar dados no banco
    RecipeType.create(name: 'Sobremesa')
    RecipeType.create(name: 'Entrada')
    User.create!(email: 'joao@email.com', password: '12345678')

    mailer_spy = class_spy(RecipesMailer)
    stub_const('RecipesMailer', mailer_spy)

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'joao@email.com'
    fill_in 'Senha', with: '12345678'
    within 'div.actions' do
      click_on 'Entrar'
    end
    click_on 'Enviar uma receita'

    within 'form#new_recipe' do
      fill_in 'Título', with: 'Tabule'
      select 'Entrada', from: 'Tipo da Receita'
      fill_in 'Cozinha', with: 'Arabe'
      fill_in 'Dificuldade', with: 'Fácil'
      fill_in 'Tempo de Preparo', with: '45'
      fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha'
      fill_in 'Como Preparar', with: 'Misturar tudo e servir. Adicione limão a gosto.'
      click_on 'Enviar'
    end

    # expectativas
    recipe = Recipe.last
    expect(RecipesMailer).to have_received(:notify_new_recipe).with(recipe.id)
    expect(page).to have_css('h1', text: 'Tabule')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Entrada')
    expect(page).to have_css('p', text: 'Arabe')
    expect(page).to have_css('p', text: 'Fácil')
    expect(page).to have_css('p', text: "45 minutos")
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha')
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text:  'Misturar tudo e servir. Adicione limão a gosto.')
  end

  scenario 'and must fill in all fields' do
    # simula a ação do usuário
    User.create!(email: 'joao@email.com', password: '12345678')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'joao@email.com'
    fill_in 'Senha', with: '12345678'
    within 'div.actions' do
      click_on 'Entrar'
    end
    click_on 'Enviar uma receita'


    within 'form#new_recipe' do
      fill_in 'Título', with: ''
      fill_in 'Cozinha', with: ''
      fill_in 'Dificuldade', with: ''
      fill_in 'Tempo de Preparo', with: ''
      fill_in 'Ingredientes', with: ''
      fill_in 'Como Preparar', with: ''
      click_on 'Enviar'
    end


    expect(page).to have_content('Não foi possível salvar a receita')
  end
end
