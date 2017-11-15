class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :category, :url, :byline

end
