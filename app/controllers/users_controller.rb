class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update, :car_index]
  before_action :correct_user,   only: [:show, :edit, :update, :car_index]
  before_action :if_seller, only: [:car_index]
  def show
    @user = User.find(params[:id])
    redirect_to cars_path
  end
  def new
    if logged_in?
      flash[:warning] = "You are already Logged In, Please log out and then sign up"
      redirect_to root_path
    else
      @user = User.new
    end
  end
  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # Handle a successful update.
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def car_index
    @cars = Car.all;
  end
  
  def car_search
    
  end
  
  def car_add
    
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,:password_confirmation, :number, :category)
    end

    # Before action

    def if_seller
      unless current_user.category == 'Seller'
        flash[:warning] = "please log in as a seller"
        redirect_to root_path
      end
    end
    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location  
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
