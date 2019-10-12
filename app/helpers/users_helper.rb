module UsersHelper
	def if_seller
	  unless current_user.category == 'Seller'
	    flash[:warning] = "please log in as a seller"
	    redirect_to root_path
	  end
	end
	def if_buyer
	  unless current_user.category == 'Buyer'
	    flash[:warning] = "please log in as a buyer"
	    redirect_to root_path
	  end
	end
	# Confirms a logged-in user.
	def logged_in_user
	  unless logged_in?
	    store_location  
	    flash[:danger] = "Please log in."
	    redirect_to login_url
	  end
	end

	# Confirms the correct user.
	def correct_user
	  @user = User.find(params[:id])
	  redirect_to(root_url) unless current_user?(@user)
	end

	def correct_log_in
	  @user = User.find(params[:user_id])
      unless current_user?(@user)
        flash[:warning] = "incorrect Url"
        redirect_to(root_url)
      end
    end

	def correct_user_car
	  @car = Car.find(params[:id])
	  unless @car.user_id == current_user.id
	    flash[:warning] = "Incorrect Url"
	    redirect_to(root_url)
	  end
	end
end
