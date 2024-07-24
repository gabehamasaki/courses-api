class UsersController < ApplicationController
  before_action :authorize_request
  before_action :load_user, only: %i[ show update destroy ]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    # Generate a random password
    value = ""; 8.times{value << ((rand(2)==1?65:97) + rand(25)).chr}
    @user = User.new(user_params().merge(password: value, role_id: params[:role_id] ? params[:role_id] : Role.find_by(name: "Member").id ))

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def load_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :role_id)
    end
end
