class AdminController < ApplicationController
  before_action :except_admin?

  def dashboard
  end

  def add_city
  end

  def city
    #@cities = City.all
  end
  #check user is admin then go else forbidden
  def except_admin?
    unless logged_in? and current_user.admin 
      flash[:danger] = "Please Log in as Administrator"
      redirect_to root_path
    end
  end
end
