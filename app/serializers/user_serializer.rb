class UserSerializer < ActiveModel::Serializer
  attributes :id, :email 
  has_many :galleries

  # has_many :artists
  # has_many :artworks
end
