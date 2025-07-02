class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!
  def admin
    @users = User.all
    @articles = Article.all
  end

  private def authorize_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: "Access denied"
    end
  end
end
