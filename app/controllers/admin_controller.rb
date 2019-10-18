class AdminController < ApplicationController
  include AdminHelper
  before_action :except_admin?

  def dashboard
  end

  def all_appointments
    @admin = User.where(admin: true)[0]
    @appointments = Appointment.where(whom_user_id: @admin.id)
  end

  def manage_appointment
    @ap = Appointment.find(params[:id])
    #binding.pry
  end

  def schedule_appointment
    @ap = Appointment.find(params[:id])
    if @ap.status == "rejected"
      flash[:warning] = "This appointment has been rejected"
      redirect_to admin_all_appointments_path
    end
  end

  def set_appointment_date
    @ap = Appointment.find(params[:id])
    @ap.date = params[:appointment][:date]
    @ap.status = "approved"
    if @ap.save and @ap.date
      Notification.create(recipient: User.find(@ap.who_user_id), actor: User.find(@ap.whom_user_id), action: "Your Appointment for verification of car ID #{@ap.car_id} is approved", notifiable: @ap)
      Notification.create(recipient: User.find(@ap.who_user_id), actor: User.find(@ap.whom_user_id), action: "Your Appointment for verification of car ID #{@ap.car_id} is scheduled at #{@ap.date}", notifiable: @ap)
      flash[:success] = "Appointment Scheduled at #{@ap.date}"
      redirect_to admin_manage_appointment_path(id: @ap.id)
    else
      flash[:danger] = "Failed to fix appointment"
      render "schedule_appointment"
    end
  end

  def reject_appointment
    @ap = Appointment.find(params[:id])
    #@ap.destroy
    @ap.status = "rejected"
    if @ap.save
      Notification.create(recipient: User.find(@ap.who_user_id), actor: User.find(@ap.whom_user_id), action: "Your Appointment for verification of car ID #{@ap.car_id} is rejected", notifiable: @ap)
      flash[:success] = "appointment has been rejected"
      redirect_to admin_all_appointments_path
    else
      flash[:warning] = "retry"
      render "manage_appointment"
    end
  end

  def accept_appointment
    @ap = Appointment.find(params[:id])
    unless @ap.date.nil?
      @ap.status = "accepted"
      @car = Car.find(@ap.car_id)
      @car.verified = true
      if @ap.save and @car.save 
        Notification.create(recipient: User.find(@ap.who_user_id), actor: User.find(@ap.whom_user_id), action: "Your Appointment for verification of car ID #{@ap.car_id} is accepted", notifiable: @ap)
        Notification.create(recipient: User.find(@ap.who_user_id), actor: User.find(@ap.whom_user_id), action: "Your car of ID #{@ap.car_id} is Verified and ready to sell", notifiable: @ap)
        flash[:success] = "Car has been accepted"
        redirect_to admin_manage_appointment_path(id: @ap.id)
      else
        flash[:warning] = "retry"
        render "manage_appointment"
      end
    else
      flash[:warning] = "Inspection Schedule is not yet fixed"
      render "manage_appointment"
    end
  end
  
end
