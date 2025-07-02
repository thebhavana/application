class UsersController < ApplicationController
  before_action :authenticate_user!, only: [ :edit, :update ]

  def show
    @user = User.find(params[:id])
     if @user != current_user
      redirect_to root_path, alert: "Access denied"
     else
      @articles = @user.articles
     end
  end
  def edit
    @user = current_user
  end
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to articles_path, notice: "Profile updated!"
    else
      render :edit
    end
  end

  private def user_params
    params.require(:user).permit(:username, :bio, :profile_picture)
  end
end
