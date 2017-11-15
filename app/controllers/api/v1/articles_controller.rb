class Api::V1::ArticlesController < ApplicationController
  before_filter :authenticate_request!

  def index
    @articles = Article.all.order(created_at: :DESC)
    render json: {'logged_in' => true}
  end

  # def create
  #   if Article.find_by(params[:id])
  #
  #     @error = {error:'Article already exists'}
  #     render json: @error
  #   else
  #   @article = Article.find_or_create_by(article_params)
  #   render json: @article
  #   end
  # end
  #
  # def show
  #   @article= Article.find(params[:id])
  #   render json: @article
  # end
  #
  # def update
  #   @article= Article.find(params[:id])
  #   @article.update(article_params)
  #   render json: @article
  # end
  #
  # def destroy
  #   @article= Article.find(params[:id])
  #   @article.delete
  #   render json: {success:'deleted'}
  #   rescue ActiveRecord::InvalidForeignKey
  #     render json: {error:'Cannot delete Article'}
  # end
  # private
  #
  # def article_params
  #   params.permit(:id, :title, :url, :byline)
  # end

end
