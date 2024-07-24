class AuthController < ApplicationController
  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      exp = 4.hours.from_now
      token = JsonWebToken.encode({ sub: user.id }, exp);

      render json: { token: token, exp: exp.strftime("%m-%d-%Y %H:%M"),
                     username: user.email }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  def register
    user = User.create(name: params[:name], email: params[:email], password: params[:password], role_id: Role.find_by(name: "Member").id)

    if user.valid?
      render json: { status: 'User register successfully' }, status: :created
    else
      render json: { error: user.errors.full_messages }, status: :bad_request
    end
  end

end
