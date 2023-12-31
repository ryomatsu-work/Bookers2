class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = current_user
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  def followings
    @user = User.find(params[:user_id])
    @following_users = @user.following_users
  end

  def followers
    @user = User.find(params[:user_id])
    @follower_users = @user.follower_users
  end

  private
    def user_params
      params.require(:user).permit(:name, :introduction, :profile_image, :address)
    end

    def ensure_correct_user
      @user = User.find(params[:id])
      unless @user == current_user
        redirect_to user_path(current_user)
      end
    end

    def ensure_guest_user
      @user = User.find(params[:id])
      if @user.guest_user?
        redirect_to user_path(current_user), notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
      end
    end
end
