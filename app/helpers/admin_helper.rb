module AdminHelper
  
  #check user is admin then go else forbidden
  def except_admin?
    unless logged_in? and current_user.admin 
      flash[:warning] = "Please Log in as Administrator"
      redirect_to root_path
    end
  end
  
end
