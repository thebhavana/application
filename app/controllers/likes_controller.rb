class LikesController < ApplicationController
  before_action :authenticate_user!
  def create
    @article = Article.find(params[:id])
    like = @article.likes.find_or_initialize_by(user: current_user)
    if like.persisted?
      like.destroy
    else
     like.save
    end
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "like_button_#{@article.id}",
          partial: "shared/like_button",
          locals: { article: @article }
        )
    end
    format.html { redirect_back fallback_location: articles_path }
    end
  end
end
