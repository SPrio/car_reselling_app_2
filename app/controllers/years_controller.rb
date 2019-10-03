class YearsController < ApplicationController
  include ApplicationHelper
  include AdminHelper
  before_action :except_admin?
  before_action :get_year, only: [:edit, :update, :destroy]

  def index
    @years = Year.all
  end

  def new
    @year = Year.new
  end

  def create
    @year = Year.new(years_params)
    if @year.start >= @year.end
      flash[:warning] = "start can't be greater than end year"
      render 'new'
    else
      if @year.save
        flash[:success] = "year range added Succesfully"
        redirect_to years_path
      else
        flash[:danger] = "Failed to add, try again"
        render 'new'
      end
    end
  end

  def edit
  end

  def update
    tmp_start = @year.start
    tmp_end = @year.end
    if @year.update(years_params)
      if @year.start >= @year.end
        flash[:warning] = "start can't be greater than end year"
        @year.start = tmp_start
        @year.end = tmp_end
        @year.save
        render 'edit'
      else
        flash[:success] = "year range has been succesfully Updated"
        redirect_to years_path
      end
    else
      flash[:danger] = "Failed to update year"
      render "edit"
    end
    
  end

  def destroy
    @year.destroy
    flash[:success] = "year range has been succesfully deleted"
    redirect_to years_path
  end

  def get_year
    @year = Year.find(params[:id])
  end


  private
  def years_params
    params.require(:year).permit(:start, :end)
  end
end
