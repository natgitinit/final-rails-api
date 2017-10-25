class PostSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :city, :state
  belongs_to :user

  # has_many :artists
  # has_many :artworks
end
