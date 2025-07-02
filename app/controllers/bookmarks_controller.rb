 class BookmarksController < ApplicationController
  before_action :authenticate_user!
  def create
    @article = Article.find(params[:id])
    bookmark = @article.bookmarks.find_or_initialize_by(user: current_user)
    if bookmark.persisted?
      bookmark.destroy
    else
      bookmark.save
    end
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "bookmark_button_#{@article.id}",
          partial: "shared/bookmark_button",
          locals: { article: @article }
        )
    end
    format.html { redirect_back fallback_location: articles_path }
  end
  end
 end
