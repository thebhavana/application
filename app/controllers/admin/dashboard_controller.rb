class Admin::DashboardController < ApplicationController
  before_action :authenticate_admin!
  def index
    @users = User.all
  end
  def show_user
    @user = User.find(params[:id])
    @articles = @user.articles
  end
  def destroy_user
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_dashboard_path, notice: "User deleted."
  end
  def destroy_article
    @article = Article.find(params[:id])
    @article.destroy
    redirect_back fallback_location: admin_dashboard_path, notice: "Article deleted."
  end
end
