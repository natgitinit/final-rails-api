class Api::V1::ArticlesController < ApplicationController
  # before_filter :authenticate_request!
  # before_action :set_article, only: [:show, :destroy]

  def index
    @articles = Article.all
    render json: @articles 
  end

  def create
    @article= Article.create(article_params)
    if @article.save
      render json: @article, status: 201
    else
      render json: { errors: @article.errors.full_messages }, status: 403
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.save
      @articles = Article.order(id: :asc)
      render json: @articles
    end
  end

  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      render json: {
        message: 'Successfully removed article'
      }
    end
  end

  private
  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.permit(:title, :category, :url, :byline, :abstract, :image_url)
  end

end
