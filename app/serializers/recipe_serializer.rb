class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :image, :name
  has_many :ingredients
end
