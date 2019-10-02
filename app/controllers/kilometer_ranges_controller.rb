class KilometerRangesController < ApplicationController
  include ApplicationHelper
  include AdminHelper
  before_action :except_admin?
  before_action :get_kilometer_range, only: [:edit, :update, :destroy]

  def index
    @kilometer_ranges = KilometerRange.all
  end

  def new
    @kilometer_range = KilometerRange.new
  end

  def create
    @kilometer_range = KilometerRange.new(model_params(:kilometer_range))
    if @kilometer_range.save
      flash[:success] = "kilometer_range added Succesfully"
      redirect_to kilometer_ranges_path
    else
      flash[:danger] = "Failed to add, try again"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @kilometer_range.update(model_params(:kilometer_range))
      flash[:success] = "kilometer_range has been succesfully Updated"
      redirect_to kilometer_ranges_path
    else
      flash[:danger] = "Failed to update kilometer_range"
      render "edit"
    end
  end

  def destroy
    @kilometer_range.destroy
    flash[:success] = "kilometer_range has been succesfully deleted"
    redirect_to kilometer_ranges_path
  end

  def get_kilometer_range
    @kilometer_range = KilometerRange.find(params[:id])
  end
end
