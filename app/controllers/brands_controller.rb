class BrandsController < ApplicationController
  include ApplicationHelper
  include AdminHelper
  before_action :except_admin?
  before_action :get_brand, only: [:edit, :update, :destroy]

  def index
    @brands = Brand.all
  end

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(model_params(:brand))
    if @brand.save
      flash[:success] = "Brand added Succesfully"
      redirect_to brands_path
    else
      flash[:danger] = "Failed to add, try again"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @brand.update(model_params(:brand))
      flash[:success] = "brand has been succesfully Updated"
      redirect_to brands_path
    else
      flash[:danger] = "Failed to update brand"
      render "edit"
    end
  end

  def destroy
    @brand.destroy
    flash[:success] = "brand has been succesfully deleted"
    redirect_to brands_path
  end

  def get_brand
    @brand = Brand.find(params[:id])
  end
end
