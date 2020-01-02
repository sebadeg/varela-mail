class MensajesController < ApplicationController

  def enviar

    # mensaje = Mensaje.find(1)
    # mensaje.header = "Cabezal.jpeg"
    # mensaje.header_data = File.read(Rails.root.join("data", 'Cabezal.jpeg'))

    # mensaje.footer = "Pie.jpeg"
    # mensaje.footer_data = File.read(Rails.root.join("data", 'Pie.jpeg'))

    # mensaje.save()

    ApplicationJob.set(wait: 1.seconds).perform_later
    result(nil,{result: "OK"})
  end


  def index
    p "Index"
    @elements = Mensaje.all
    result(nil,@elements)
  end

  def show    
    p "Show"
    @element = Mensaje.find(params[:id]) rescue nil
    result(mensajes_path,@element)
  end

  def new
    p "New"
    @element = Mensaje.new()
  end

  def create
    p "Create"
    #@element = Mensaje.new( name: params["company"]["name"] )
    #if ( @element != nil ) && ( !@element.save )
    #  @element = nil
    #end
    result(mensajes_path,@element)
  end

  def edit
    p "Edit"
    @element = Mensaje.find(params[:id]) rescue nil
  end

  def update
    p "Update"
    @element = Mensaje.find(params[:id]) rescue nil    
    # if ( @element != nil ) && ( !@element.update( name: params["company"]["name"] ) )
    #   @element = nil
    # end
    result(mensajes_path,@element)
  end

  def destroy
    p "Destroy"
    @element = Company.find(params[:id]) rescue nil
    # if ( @element != nil ) && ( !@element.destroy )
    #   @element = nil
    # end
    result(mensajes_path,@element)
  end


end
