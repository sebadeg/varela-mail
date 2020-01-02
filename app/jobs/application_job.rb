class ApplicationJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    p "perform job"
    
    mensaje = Mensaje.find(1) rescue nil
    if mensaje != nil
      UserMailer.enviar(mensaje).deliver_now
    end

#  	 Mensaje.all.each do |mensaje|
#      ApplicationMailer.send_mail(mensaje).deliver_now
#    end
  end
end
