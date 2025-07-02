class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :prevent_user_admin_conflict

  protected def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      admin_dashboard_path  # admin_dashboard_path if namespaced
    elsif resource.is_a?(User)
      #  user_path(resource)   # redirects to /users:id
      my_articles_path
    else
      root_path
    end
  end

private def prevent_user_admin_conflict
  if admin_signed_in? && user_signed_in?
    sign_out(:user)  # or sign_out(:admin), depending on preference
  end
end
protected def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      new_admin_session_path   # redirects to admin login page
    elsif resource_or_scope == :user
      new_user_session_path    # redirects to user login page
    else
      root_path
    end
  end
end
