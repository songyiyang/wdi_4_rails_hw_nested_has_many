class ArticlesController < ApplicationController
  before_action :get_user

  def index
    @users = User.all
    @articles = if params[:show_all].present?
      Article.all
    else
      Article.where('updated_at > ?', 7.days.ago)
    end.order(updated_at: :desc)
  end

  def show
    find_article
  end

  def new
   # @article = Article.new
    @article = @user.articles.new
  end

  def create
    article = Article.create!(article_params)
    @user.articles << article
    redirect_to user_article_path(@user.id, article.id)    
    
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    article = @user.articles.new(article_params)
    if article.save!
      flash[:notice] = 'Updated the article!'
      redirect_to user_article_path(@user, article)
    else
      flash.now[:errors] = @article.errors.full_messages
      render :edit
    end
  end

  def destroy
    find_article
    if @article.destroy
      flash[:notice] = 'Deleted the article!'
      redirect_to action: :index
    else
      # Assume whatever prevented the destroy added an error message for us
      flash.now[:errors] = @article.errors.full_messages
      redirect_to :back
    end
  end

  private

  def find_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body)
  end
  def get_user
    @user = User.find(params[:user_id]) if params.key?(:user_id)
  end
end
