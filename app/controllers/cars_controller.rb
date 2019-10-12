class CarsController < ApplicationController
  include UsersHelper
  before_action :get_car, only: [:edit, :update, :destroy, :show, :quotation]
  before_action :logged_in_user, except: [:search]
  before_action :if_buyer, only: [:view]
  before_action :if_seller, only: [:show, :edit, :destroy]
  before_action :correct_log_in, except: [:search, :detail]
  before_action :correct_user_car, except: [:index, :show, :view, :search, :detail, :quotation]
  

  def index
    @cars = Car.where(user_id: params[:user_id])
  end

  def new
    @car = Car.new
  end

  def show
    if Appointment.where(car_id: @car.id) == []
      @requested = false
    else
      @requested = true
    end
  end

  def create
    @car = Car.new(cars_params)
    @car.user_id = current_user.id
    @car.quotation = Condition.where(condition: @car.condition).pluck(:cost)[0]
    if @car.save
      flash[:success] = "car added Succesfully"
      redirect_to user_cars_path
    else
      flash[:danger] = "Failed to add, try again"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @car.update(cars_params)
      flash[:success] = "car has been succesfully Updated"
      redirect_to user_cars_path
    else
      flash[:danger] = "Failed to update car"
      render "edit"
    end
  end

  def destroy
    @car.destroy
    flash[:success] = "car has been succesfully deleted"
    redirect_to user_cars_path
  end

  def get_car
    @car = Car.find(params[:id])
  end
  
  def quotation
    @price = nil
    @number = User.find(current_user.id).number
    if params[:number] == @number
      @price = Condition.where(condition: @car.condition).pluck(:cost)[0]
    elsif params[:number]
      flash[:warning] = "The phone number is different from the saved one"
      render 'quotation'
    else
      render 'quotation'
    end
  end

  def apply_appointment
    @car = Car.find(params[:id])
    @seller = User.find(params[:user_id])
    @admin = User.where(admin: true)[0]
    @appointment = Appointment.new(who_user_id: @seller.id, whom_user_id: @admin.id, car_id: @car.id, status: "in process")
    if @appointment.save
      flash[:success] = "Your Appointment is in process with admin for inspection of car"
    else
      flash[:danger] = "Request failed please retry"
    end
    redirect_to user_car_path(id: @car, user_id: @seller)
  end

  def search
    #@cars = Car.where(status: 'verified')
    if params[:search].nil? 
      @cars = Car.where(verified: true)
    else
      @params_city = params[:city]
      @params_brand = params[:brand]
      @params_model = params[:model]
      @params_registration_year = params[:registration_year]
      @params_variant = params[:variant]
      @params_registration_state = params[:registration_state]
      @params_kilometer_driven = params[:kilometer_driven]
      @cars = Car.filtered_search(params[:search],params[:city],params[:brand],params[:model],params[:registration_year],params[:variant],params[:registration_state],params[:kilometer_driven])
      #@cars = @cars.where(status: "verified")
      render 'search'
    end
  end
  
  def detail
    redirect_to user_car_path(user_id: current_user.id, id: params[:id])
  end

  def view
    @car = Car.find(params[:id])
  end

  def apply_to_buy
    
  end

  private
  def cars_params
    params.require(:car).permit(:brand, :model, :variant, :kilometer_range, :city, :state, :condition, :year)
  end

end
