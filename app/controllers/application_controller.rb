class ApplicationController < ActionController::API
  def encode_token(payload)
    JWT.encode(payload, ENV['RAILS_MASTER_KEY'])
  end

  def decode_token
    auth_header = request.headers['Authorization']
    if auth_header
        token = auth_header.split(' ').last
      begin
        JWT.decode(token, ENV['RAILS_MASTER_KEY'], true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def authorized_user
    decode_token = decode_token()
    if decode_token
      user_id = decode_token[0]['user_id']
      @user = User.find(user_id)
    end
  end

  def authorized
    render json: { message: 'Unauthorized.' }, status: :unauthorized unless authorized_user
  end

end
