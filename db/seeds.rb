User.create(:name => "Admin", :email => "admin@admin.com", :password => "password")

# Recipe.create(:name => "Jambalaya", :instructions => "Cook sausage in hot oil in a Dutch oven over medium-high heat, stirring constantly, 5 minutes or until browned. Remove sausage with a slotted spoon. Add diced onion and next 7 ingredients to hot drippings; sauté 5 minutes or until vegetables are tender. Stir in tomatoes, next 3 ingredients, and sausage. Bring to a boil over high heat. Cover, reduce heat to medium, and simmer, stirring occasionally, 20 minutes or until rice is tender. Stir in shrimp; cover and cook 5 minutes or just until shrimp turn pink. Stir in parsley. Serve immediately. To Freeze: Prepare recipe as directed. Line bottom and sides of a 13- x 9-inch baking dish with heavy-duty aluminum foil, allowing 2 to 3 inches to extend over sides; fill with jambalaya. Cover and freeze. To serve, remove foil, return casserole to original baking dish; cover and thaw in refrigerator 24 hours. Let stand at room temperature 30 minutes. Bake at 350° until thoroughly heated.")

# Recipe.create(:name => "Macaroni and Cheese", :instructions => "Preheat the oven to 350 degrees F. Cook the macaroni until still slightly firm. Drain and set aside. In a small bowl, beat the egg. In a large pot, melt the butter and sprinkle in the flour. Whisk together over medium-low heat. Cook for a couple of minutes, whisking constantly. Don't let it burn. Pour in the milk, add the mustard and whisk until smooth. Cook until very thick, about 5 minutes. Reduce the heat to low. Take 1/4 cup of the sauce and slowly pour it into the beaten egg, whisking constantly to avoid cooking the eggs. Whisk together until smooth. Pour the egg into the sauce, whisking constantly. Stir until smooth. Add in the cheese and stir to melt. Add 1/2 teaspoon salt, 1/2 teaspoon seasoned salt and the pepper. Add any additional spices if desired. Taste the sauce and add more salt and seasoned salt as needed! DO NOT UNDERSALT. Pour in the drained, cooked macaroni and stir to combine. Serve immediately (while it's still very creamy) or pour into a buttered baking dish, top with extra cheese and bake until bubbly and golden on top, 20 to 25 minutes.")

# Ingredient.create(:name => "Dried Macaroni")

# Ingredient.create(:name => "Egg")

# Ingredient.create(:name => "Butter")

# Ingredient.create(:name => "Milk")

# Ingredient.create(:name => "Salt")

# Ingredient.create(:name => "Andouille Sausage")

# Ingredient.create(:name => "Canola Oil")

# Ingredient.create(:name => "Sweet Onion")

# Ingredient.create(:name => "Celery")

# RecipeIngredient.create(:recipe_id => 2, :ingredient_id => 1, :quantity => "4 cups")

# RecipeIngredient.create(:recipe_id => 2, :ingredient_id => 2, :quantity => "1")

# RecipeIngredient.create(:recipe_id => 2, :ingredient_id => 3, :quantity => "4 tablespoons")

# RecipeIngredient.create(:recipe_id => 2, :ingredient_id => 4, :quantity => "2 1/2 cups")

# RecipeIngredient.create(:recipe_id => 2, :ingredient_id => 5, :quantity => "1 teaspoon")

# RecipeIngredient.create(:recipe_id => 1, :ingredient_id => 6, :quantity => "1 pound")

# RecipeIngredient.create(:recipe_id => 1, :ingredient_id => 7, :quantity => "2 tablespoon")

# RecipeIngredient.create(:recipe_id => 1, :ingredient_id => 8, :quantity => "2 cups")

# RecipeIngredient.create(:recipe_id => 1, :ingredient_id => 9, :quantity => "1 cup")

# CartRecipe.create(:recipe_id => 1, :cart_id => 1)

# CartRecipe.create(:recipe_id => 2, :cart_id => 1)
