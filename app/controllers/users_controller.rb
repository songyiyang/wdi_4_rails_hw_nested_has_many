class UsersController < ApplicationController
  def show
  end

  def index
    @users = if params[:show_all].present?
      User.all
    else
      User.where('updated_at > ?', 7.days.ago)
    end.order(updated_at: :desc)
  end

  def new
    @user = User.new
  end

  def update
  end

  def edit
  end

  def destroy
  end

  def create
    @user = User.new(user_params)

    if @user.save
        redirect_to users_path
    else
      # Using flash.now[] because we want it to appear on *this* request
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def find_blat
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
