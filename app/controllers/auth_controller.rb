class AuthController < ApplicationController
  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      exp = 2.minutes.from_now
      token = JsonWebToken.encode({ sub: user.id }, exp.to_i);

      render json: { token: token, exp: exp.strftime("%m-%d-%Y %H:%M"),
                     username: user.email }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

end
