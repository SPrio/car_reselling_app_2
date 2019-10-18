class StatesController < ApplicationController
  include ApplicationHelper
  include AdminHelper
  before_action :except_admin?
  before_action :get_state, only: [:edit, :update, :destroy]

  def index
    @states = State.all
  end

  def new
    @state = State.new
  end

  def create
    @state = State.new(model_params(:state))
    if @state.save
      flash[:success] = "state added Succesfully"
      redirect_to states_path
    else
      flash[:danger] = "Failed to add, try again"
      render "new"
    end
  end

  def edit
  end

  def update
    if @state.update(model_params(:state))
      flash[:success] = "state has been succesfully Updated"
      redirect_to states_path
    else
      flash[:danger] = "Failed to update state"
      render "edit"
    end
  end

  def destroy
    @state.destroy
    flash[:success] = "state has been succesfully deleted"
    redirect_to states_path
  end

  def get_state
    @state = State.find(params[:id])
  end
end
