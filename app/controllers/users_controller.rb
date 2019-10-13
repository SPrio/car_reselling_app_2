class UsersController < ApplicationController
  include UsersHelper
  before_action :logged_in_user, only: [:show, :edit, :update, :car_index]
  before_action :correct_user,   only: [:show, :edit, :update, :my_appointments]

  def show
    @user = User.find(params[:id])
    redirect_to user_cars_path(current_user)
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

  def my_appointments
    @admin = User.where(admin: true)[0]
    #binding.pry
    @user = User.find(params[:id])
    @admin_appointments = Appointment.where(whom_user_id: @admin.id, who_user_id: params[:id])
    @buyer_appointments = []
    User.where(category: "Buyer").pluck(:id).each do |b_id|
      @buyer_appointments.append(Appointment.where(who_user_id: @user, whom_user_id: b_id))
    end
    @buyer_appointments.shift
    print @buyer_appointments

    @seller_appointments = Appointment.where(whom_user_id: params[:id])
  end

  def manage_appointment
    @ap =Appointment.find(params[:id])
  end

  def schedule_appointment
    @ap = Appointment.find(params[:id])
    if @ap.status == 'rejected'
      flash[:warning] = "This appointment has been rejected"
      redirect_to my_appointments_user_path(current_user)
    end
  end

  def set_appointment_date
    @ap = Appointment.find(params[:id])
    @ap.date = params[:appointment][:date]
    @ap.status = "approved"
    if @ap.save and @ap.date
      flash[:success] = "Appointment Scheduled at #{@ap.date}"
      redirect_to my_appointments_user_path(current_user)
    else
      flash[:danger] = "Failed to fix appointment"
      render 'schedule_appointment'
    end
  end
  def reject_appointment
    @ap = Appointment.find(params[:id])
    #@ap.destroy
    @ap.status = 'rejected'
    if @ap.save
      flash[:success] = "appointment has been rejected"
      redirect_to my_appointments_user_path(current_user)
    else
      flash[:warning] = "retry"
      render 'manage_appointment'
    end
  end

  def accept_appointment
    @ap = Appointment.find(params[:id])
    @ap.status = "accepted"
    @car = Car.find(@ap.car_id)
    @car.sold = true
    if @ap.save and @car.save 
      flash[:success] = "The Car has been sold"
      redirect_to my_appointments_user_path(current_user)
    else
      flash[:warning] = "retry"
      render 'manage_appointment'
    end
  end
  def places
    @places = City.all;
  end
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,:password_confirmation, :number, :category)
    end

end
