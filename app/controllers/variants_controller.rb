class VariantsController < ApplicationController
  include ApplicationHelper
  include AdminHelper
  before_action :except_admin?
  before_action :get_variant, only: [:edit, :update, :destroy]

  def index
    @variants = Variant.all
  end

  def new
    @variant = Variant.new
  end

  def create
    @variant = Variant.new(model_params(:variant))
    if @variant.save
      flash[:success] = "variant added Succesfully"
      redirect_to variants_path
    else
      flash[:danger] = "Failed to add, try again"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @variant.update(model_params(:variant))
      flash[:success] = "variant has been succesfully Updated"
      redirect_to variants_path
    else
      flash[:danger] = "Failed to update variant"
      render "edit"
    end
  end

  def destroy
    @variant.destroy
    flash[:success] = "variant has been succesfully deleted"
    redirect_to variants_path
  end

  def get_variant
    @variant = Variant.find(params[:id])
  end
end
