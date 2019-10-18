class ModelsController < ApplicationController
  include ApplicationHelper
  include AdminHelper
  before_action :except_admin?
  before_action :get_model, only: [:edit, :update, :destroy]

  def index
    @models = Model.all
  end

  def new
    @model = Model.new
  end

  def create
    @model = Model.new(models_params)
    if @model.save
      flash[:success] = "model added Succesfully"
      redirect_to models_path
    else
      flash[:danger] = "Failed to add, try again"
      render "new"
    end
  end

  def edit
  end

  def update
    if @model.update(models_params)
      flash[:success] = "model has been succesfully Updated"
      redirect_to models_path
    else
      flash[:danger] = "Failed to update model"
      render "edit"
    end
  end

  def destroy
    @model.destroy
    flash[:success] = "model has been succesfully deleted"
    redirect_to models_path
  end

  def get_model
    @model = Model.find(params[:id])
  end

  def get_brand_name(model_data)
    Brand.find(model_data.brand_id).name
  end
  helper_method :get_brand_name
  
  private
  def models_params
    params.require(:model).permit(:name, :brand_id)
  end
end
