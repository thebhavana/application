class UsersController < ApplicationController
  # Only logged in users can edit or update profiles
  before_action :authenticate_user!, only: [ :edit, :update ]
  def show
    @user = User.find(params[:id])
    @articles = @user.articles # Show user's own params
  end

  def edit
    @user = current_user    # Accessible by /users/:id/edit
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to @user, notice: "Profile updated!"
    else
      render :edit
    end
  end

  private def user_params
    params.require(:user).permit(:username, :bio, :profile_picture)
  end
end
