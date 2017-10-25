class ApplicationController < ActionController::API
  before_action :authenticate

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find(decoded_token["user"]) if auth_present?
  end

  def authenticate
    render json: {error: "unauthorized"}, status: 401 unless logged_in?
  end


  private

  def auth_present?
    !!request.env.fetch("HTTP_AUTHORIZATION","").scan(/Bearer/).flatten.first
  end

  def decoded_token
    Auth.decode(token)
  end

  def token
    request.env["HTTP_AUTHORIZATION"].scan(/Bearer (.*)$/).flatten.last
  end

end


# private
#
# def issue_token payload
#   JWT.encode(payload, secret, algorithm)
# end
#
# def authorize_user!
#   if !current_user.present?
#     render json: {error: 'No user id present'}
#   end
# end
#
# def current_user
#   @current_user ||= User.find_by(id: token_user_id)
# end
#
# def token_user_id
#   decoded_token.first['id']
# end
#
# def decoded_token
#   if token
#     begin
#       JWT.decode(token,secret, true, {algorithm: algorithm})
#     rescue JWT::DecodeError
#       return [{}]
#     end
#   else
#     [{}]
#   end
# end
#
# def token
#   request.headers['Authorization']
# end
#
# def secret
#   "events"
# end
#
# def algorithm
#   "HS256"
# end
