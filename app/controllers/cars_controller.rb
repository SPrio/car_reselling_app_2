class CarsController < ApplicationController
  before_action :get_car, only: [:edit, :update, :destroy, :show, :quotation]

  def index
    @cars = Car.all
  end

  def new
    @car = Car.new
  end

  def show
  end

  def create
    @car = Car.new(cars_params)
    @car.user_id = current_user.id
    @car.quotation = Condition.where(condition: @car.condition).pluck(:cost)[0]
    if @car.save
      flash[:success] = "car added Succesfully"
      redirect_to cars_path
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
      redirect_to cars_path
    else
      flash[:danger] = "Failed to update car"
      render "edit"
    end
  end

  def destroy
    @car.destroy
    flash[:success] = "car has been succesfully deleted"
    redirect_to cars_path
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
  private
  def cars_params
    params.require(:car).permit(:brand, :model, :variant, :kilometer_range, :city, :state, :condition, :year)
  end
  
end
