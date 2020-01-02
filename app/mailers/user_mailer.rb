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
    
    data = File.read(Rails.root.join("app/assets/images/Cabezal.jpg"))
    IO.binwrite(Rails.root.join("public/Cabezal.jpg"), data)

    #MensajeAdjunto.where("mensaje_id=?",mensaje.id).each do |adjunto|
    #  attachments[adjunto.nombre] = adjunto.datos #File.read(file_path)
    #end
    #@body = mensaje.body
    #attachments["archivo.jpg"] = File.read("#{Rails.root.to_s}/app/assets/images/Cabezal.jpg")
    #attachments.inline["Cabezal.jpg"] = File.read("#{Rails.root.to_s}/app/assets/images/Cabezal.jpg")
    #@attachments = attachments

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
