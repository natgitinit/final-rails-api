require 'hyperclient'

class Api::V1::PostsController < ApplicationController

  def index
    @posts = Post.all.order(created_at: :DESC)
    render json: @posts, status: 201
  end

  def create
    if Post.find_by(params[:id])

      @error = {error:'Post already exists'}
      render json: @error
    else
    @post= Post.find_or_create_by(post_params)
    render json: @post status: 201
    end
  end

  def show
    @post= Post.find(params[:id])
    render json: @post status: 201
  end

  def update
    @post= Post.find(params[:id])
    @postupdate(postparams)
    render json: @post status: 201
  end

  def destroy
    @post= Post.find(params[:id])
    @post.delete
    render json: {success:'deleted'}
    rescue ActiveRecord::InvalidForeignKey
      render json: {error:'Cannot delete Post'}
  end

  def fetch_api

    client_id = ENV['client_id']
    client_secret = ENV['client_secret']
    xapp_token = ENV['xapp_token']


    api = Hyperclient.new('https://api.artsy.net/api/') do |api|
      api.headers['Accept'] = 'application/vnd.artsy-v2+json'
      api.headers['X-Xapp-Token'] = xapp_token
      api.connection(default: false) do |conn|
        conn.use FaradayMiddleware::FollowRedirects
        conn.use Faraday::Response::RaiseError
        conn.request :json
        conn.response :json, content_type: /\bjson$/
        conn.adapter :net_http
      end
    end
    andy_warhol = api.artist(id: 'andy-warhol')
    puts "#{andy_warhol.name} was born in #{andy_warhol.birthday} in #{andy_warhol.hometown}"
  end

  private

  def post_params
    params.permit(:id, :name, :city, :state, :user_id)
  end

end
