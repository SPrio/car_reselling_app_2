class CitiesController < ApplicationController
  include ApplicationHelper
  include AdminHelper
  before_action :except_admin?
  before_action :get_city, only: [:edit, :update, :destroy]

  def index
    @cities = City.all
  end

  def new
    @city = City.new
  end

  def create
    @city = City.new(model_params(:city))
    if @city.save!
      flash[:success] = "City added Succesfully"
      redirect_to cities_path
    else
      flash[:danger] = "Failed to add, try again"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @city.update(model_params(:city))
      flash[:success] = "City has been succesfully Updated"
      redirect_to cities_path
    else
      flash[:danger] = "Failed to update City"
      render "edit"
    end
  end

  def destroy
    @city.destroy
    flash[:success] = "City has been succesfully deleted"
    redirect_to cities_path
  end

  def get_city
    @city = City.find(params[:id])
  end
end
