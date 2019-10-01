class AdminController < ApplicationController
  before_action :is_admin?

  def dashboard
  end

  #check user is admin then go back else forbidden
  def is_admin?
    unless logged_in? and current_user.admin
      store_location  
      flash[:danger] = "Please Log in as Administrator"
      redirect_to root_path
    end
  end
end
