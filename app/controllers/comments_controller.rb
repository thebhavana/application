class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article
  before_action :set_comment, only: [ :destroy, :edit, :update ]
  before_action :authorize_comment, only: [ :edit, :update, :destroy ]

  def create
    @comment = @article.comments.build(comment_params.merge(user: current_user))
    if @comment.save
      redirect_to articles_path, notice: "Comment posted"
    else
      redirect_to articles_path, alert: "Comment cannot be blank"
    end
  end

  def destroy
    @comment.destroy
    redirect_to articles_path, notice: "Comment deleted"
  end

  def edit
    # Renders edit view inline or full-page
  end

  def update
    if @comment.update(comment_params)
      redirect_to articles_path, notice: "Comment updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private def set_article
    @article = Article.find(params[:article_id])
  end

  def set_comment
    @comment = @article.comments.find(params[:id])
  end

  def authorize_comment
    redirect_to articles_path, alert: "Not authorized" unless @comment.user == current_user
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
