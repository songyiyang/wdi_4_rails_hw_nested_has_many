class CommentsController < ApplicationController

  # before filter to get the article that this comment belongs.
  before_action :get_article,  :get_user

  def index
    if !@article
      @comments = Comment.all
    else
      @comments = @article.comments      
    end
  end

  def show
  end

  def new
    @comment = Comment.new
  end

  def create
    @article.comments << Comment.create!(comments_params)
    redirect_to user_article_path(@user.id, @article.id)    
  end

  private

  def comments_params
    params.require(:comment).permit(:body)
  end

  def get_article
    @article = Article.find(params[:article_id]) if params.key?(:article_id)
  end
  def get_user
    @user = User.find(params[:user_id]) if params.key?(:user_id)
  end
end
