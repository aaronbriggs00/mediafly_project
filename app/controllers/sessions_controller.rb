class SessionsController < ApplicationController
  #returns a bearer token for a successful login
  def create
    user = User.find_by(username: params[:username])
    
    if user && user.authenticate(params[:password])
      jwt = JWT.encode(
        {
          user_id: user.id, # the data to encode into the bearer token
          exp: 72.hours.from_now.to_i # the expiration time
        },
        Rails.application.credentials.fetch(:secret_key_base), # the secret key
        "HS256" # the encryption algorithm
      )
      render json: { jwt: jwt, username: user.username, user_id: user.id }, status: :created
    else
      render json: {}, status: :unauthorized
    end
  end
end
