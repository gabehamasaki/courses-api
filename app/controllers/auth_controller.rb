class AuthController < ApplicationController
  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      token = encode_token(user_id: user.id)
      time = Time.now + 24.hours.to_i

      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                     username: user.email }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

end
