class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}
  def show
   @user = User.find(params[:id])
   @book = Book.new
   @books = Book.where(user_id: params[:id])
  end
  
  
  
  def new
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(current_user.id)
    else
      render "users/sign_up"
    end
  end  
  
  def index
    @user = current_user
    @users = User.all 
    @book = Book.new
  end
    
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice]="You have updated user successfully."
      redirect_to "/users/#{current_user.id}"
    else
        render :edit
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
  def ensure_correct_user
    @user = User.find(params[:id])
    if @user.id  != current_user.id
      redirect_to user_path(current_user.id)
    end
      
  end
end
