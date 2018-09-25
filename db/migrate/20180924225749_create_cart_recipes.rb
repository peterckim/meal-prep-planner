class CreateCartRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_recipes do |t|
      t.belongs_to :cart, index: true
      t.belongs_to :recipe, index: true
      t.timestamps
    end
  end
end
