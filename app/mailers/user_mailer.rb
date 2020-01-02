class UserMailer < ApplicationMailer


  def enviar(mensaje)
    p "enviar"
    p mensaje

    delivery_options = {
      address: "smtp.varela.edu.uy",
      port: 587,
      domain: "varela.edu.uy", 
      user_name: mensaje.from,
      password: mensaje.from_password,
      authentication: "plain",
      enable_starttls_auto: true,
      openssl_verify_mode: 'none'
    }
    
    @header_file = "cabezal_#{mensaje.id}_#{mensaje.header}"
    @footer_file = "cabezal_#{mensaje.id}_#{mensaje.footer}"
	@body = mensaje.body

    IO.binwrite(Rails.root.join("public/#{@header_file}"), mensaje.header_data)
    IO.binwrite(Rails.root.join("public/#{@footer_file}"), mensaje.footer_data)

    MensajeAdjunto.where("mensaje_id=?",mensaje.id).each do |adjunto|
      attachments[adjunto.nombre] = adjunto.datos
    end

    mail( 
      from: mensaje.from, 
      to: mensaje.to,
      reply_to: mensaje.reply_to,
      bcc: mensaje.bcc,
      subject: mensaje.subject,
      delivery_method_options: delivery_options
    )

  end

end
