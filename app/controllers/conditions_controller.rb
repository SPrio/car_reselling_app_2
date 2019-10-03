class ConditionsController < ApplicationController
  include ApplicationHelper
  include AdminHelper
  before_action :except_admin?
  before_action :get_condition, only: [:edit, :update, :destroy]

  def index
    @conditions = Condition.all
  end

  def new
    @condition = Condition.new
  end

  def create
    @condition = Condition.new(conditions_params)
    if @condition.save
      flash[:success] = "condition added Succesfully"
      redirect_to conditions_path
    else
      flash[:danger] = "Failed to add, try again"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @condition.update(conditions_params)
      flash[:success] = "condition has been succesfully Updated"
      redirect_to conditions_path
    else
      flash[:danger] = "Failed to update condition"
      render "edit"
    end
  end

  def destroy
    @condition.destroy
    flash[:success] = "condition has been succesfully deleted"
    redirect_to conditions_path
  end

  def get_condition
    @condition = Condition.find(params[:id])
  end

  private
  def conditions_params
    params.require(:condition).permit(:condition, :cost)
  end
end
