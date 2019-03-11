class RemoveAttributesFromRecipes < ActiveRecord::Migration[5.2]
  def change
    remove_column :recipes, :recipe_type, :string
  end
end
