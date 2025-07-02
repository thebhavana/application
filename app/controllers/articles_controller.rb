class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [ :index ]
  before_action :set_article, only: [ :edit, :update, :destroy ]
  before_action :authorize_user!, only: [ :edit, :update, :destroy ]
  def index
    @articles = paginate_search(Article.all)
  end
  def new
    @article = Article.new
  end
  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      flash[:notice] = "Created successfully"
      redirect_to articles_path
    else
      flash[:alert] = "Issues with creating article"
      render :new, status: :unprocessable_entity
    end
  end
  def edit
  end
  def update
    if @article.update(article_params)
      redirect_to my_articles_path, notice: "Article is updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end
  def destroy
    @article.destroy
    flash[:notice] = "Article deleted"
    redirect_to articles_path
  end
  def liked
    base = Article.joins(:likes).where(likes: { user_id: current_user.id }).distinct
    @articles = paginate_search(base)
    render :index
  end
  def bookmarked
    base = Article.joins(:bookmarks).where(bookmarks: { user_id: current_user.id }).distinct
    @articles = paginate_search(base)
    render :index
  end
  def my_articles
    base = current_user.articles
    @articles = paginate_search(base)
    render :index
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
  # DRY Pagination + Search
  def paginate_search(scope)
    if params[:query].present?
      results = scope.search(params[:query])
      scope = Article.where(id: results.map(&:id))  # NOTE: fixed typo here
    end
    scope.includes(:user, media_attachments: :blob).page(params[:page]).per(4)
  end
  def article_params
    params.require(:article).permit(:title, :body, media: [])
  end
end
