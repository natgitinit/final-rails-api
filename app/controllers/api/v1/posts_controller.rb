require 'hyperclient'

class Api::V1::PostsController < ApplicationController
  before_filter :authenticate_request!

  def index
    @posts = Post.all.order(created_at: :DESC)
    render json: {'logged_in' => true}
  end

  def create
    if Post.find_by(params[:id])

      @error = {error:'Post already exists'}
      render json: @error
    else
    @post= Post.find_or_create_by(post_params)
    render json: @post
    end
  end

  def show
    @post= Post.find(params[:id])
    render json: @post
  end

  def update
    @post= Post.find(params[:id])
    @post.update(post_params)
    render json: @post
  end

  def destroy
    @post= Post.find(params[:id])
    @post.delete
    render json: {success:'deleted'}
    rescue ActiveRecord::InvalidForeignKey
      render json: {error:'Cannot delete Post'}
  end

#   def artsy
#   @resp = Faraday.get 'https://api.artsy.net/api/' do |req|
#     req.params['client_id'] = ENV['CLIENT_ID']
#     req.params['client_secret'] = ENV['CLIENT_SECRET']
#     req.headers['X-Xapp-Token'] = xapp_token
#     req.params['v'] = '20160201'
#   end
#   body = JSON.parse(@resp.body)
#     if @resp.success?
#       @venues = body["response"]["artists"]
#     else
#       @error = body["meta"]["errorDetail"]
#   end
#   render 'search'
# end

  def artsy
    client_id = ENV['client_id']
    client_secret = ENV['client_secret']
    xapp_token = ENV['xapp_token']

    api = Hyperclient.new('https://api.artsy.net/api/') do |api|
      api.headers['Accept'] = 'application/vnd.artsy-v2+json'
      api.headers['client_id'] = ENV['CLIENT_ID']
      api.headers['client_secret'] = ENV['CLIENT_SECRET']
      api.headers['X-Xapp-Token'] = xapp_token
      api.connection(default: false) do |conn|
        conn.use FaradayMiddleware::FollowRedirects
        conn.use Faraday::Response::RaiseError
        conn.request :json
        conn.response :json, content_type: /\bjson$/
        conn.adapter :net_http
      end
    end
    # andy_warhol = api.artist(id: 'andy-warhol')
    # puts "#{andy_warhol.name} was born in #{andy_warhol.birthday} in #{andy_warhol.hometown}"
  end

  private

  def post_params
    params.permit(:id, :name, :city, :state, :user_id)
  end

end
