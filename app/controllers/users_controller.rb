class UsersController < ApplicationController
  def account
    @user = User.find(current_user.id)
  end

  def profile
    @user = User.find(current_user.id)
  end

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  private
    def user_params
      params.require(:user).permit(:user_name, :user_avatar, :user_profile)
    end
end
