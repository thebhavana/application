class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_article, only: [ :show, :edit, :update, :destroy, :like, :bookmark ]
  before_action :authorize_user!, only: [ :edit, :update, :destroy ]
  def index
    @articles = Article.search(params[:query])
  end
  def show
    @word_count = @article.word_count
    # @title_caps = @article.uppercase_title
    @intro = @article.brief_intro
  end
  def new
    @article = Article.new
  end
  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      redirect_to articles_path, notice: "Article created successfully"
    else
      flash[:alert] = "Issues with creating article"
      render :new, status: :unprocessable_entity
    end
  end
  def edit
  end
  def update
    # Remove previous media if new ones are uploaded
    @article.media.purge if params[:article][:media]
    if @article.update(article_params)
      redirect_to @article, notice: "Article updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end
  def destroy
    @article.destroy
    flash[:notice] = "Article destroyed"
    redirect_to root_path
  end
  def liked
    liked_articles = current_user.liked_articles
    @articles = liked_articles.search(params[:query])
  end
  def bookmarked
    bookmarked_articles = current_user.bookmarked_articles
    @articles = bookmarked_articles.search(params[:query])
  end
  def my_articles
    @articles = current_user.articles.search(params[:query])
  end
  private
  def set_article
    @article = Article.find(params[:id])
  end
  def authorize_user!
    unless @article.user == current_user
      redirect_to root_path, alert: "You are not authorized to perform this action"
    end
  end
  def article_params
    params.require(:article).permit(:title, :body, media: [])
  end
end
