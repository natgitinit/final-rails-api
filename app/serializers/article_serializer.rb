class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :category, :url, :byline, :abstract

end
