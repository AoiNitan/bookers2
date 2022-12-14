class UsersController < ApplicationController
  before_action :correct_user, only: [:update,:edit]


  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(current_user)
    end
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @booknew = Book.new
  end

  def index
    @user = current_user
    @users = User.all
    @booknew = Book.new
  end



  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
