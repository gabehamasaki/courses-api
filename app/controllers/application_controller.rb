class ApplicationController < ActionController::API
  before_action :authorize_request, except: %i[login register]

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)

      if @decoded.nil?
        render json: { error: 'Unauthorized' }, status: :unauthorized
        return
      end

      @current = User.find(@decoded[:sub])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Unauthorized' }, status: :unauthorized
    rescue JWT::DecodeError
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

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

  def logout
    @current = nil
    render json: { status: 'Logged out successfully' }, status: :ok
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
