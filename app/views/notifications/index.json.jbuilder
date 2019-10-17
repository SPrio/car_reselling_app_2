json.array! @notifications do |notification|
	#json.recipient notification.recipient.name
	json.id notification.id
  	json.action notification.action
  	#json.notifiable notification.notifiable
    #json.url appointment_path(notification.notifiable.appointment, anchor: dom_id(notification.notifiable))
end