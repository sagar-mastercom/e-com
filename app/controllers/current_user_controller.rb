class CurrentUserController < ApplicationController
  before_action :authenticate_user!
  def index
    render json: current_user, status: :ok
  end

  def all_users
    @users = User.all
    render json: {
      'users':@users
    }
  end

  def update_user
    puts "Update User Status : #{current_user.id}"

    @user = current_user
    if current_user.update user_params
      render json: current_user
    else
      render json: { error: current_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.permit(:email)
  end

end
