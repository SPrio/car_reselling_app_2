class AdminController < ApplicationController
  include AdminHelper
  before_action :except_admin?

  def dashboard
  end

end
