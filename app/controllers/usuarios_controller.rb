class UsuariosController < ApplicationController

  require 'securerandom'

  def index
    p "Index"
    @elements = Usuario.all
    result(nil,@elements)
  end

  def show    
    p "Show"
    @element = Usuario.find(params[:id]) rescue nil
    result(usuarios_path,@element)
  end

  def new
    p "New"
    @element = Usuario.new()
  end

  def create
    p "Create"  
    if ( params["usuario"]["password"] == params["usuario"]["password_confirm"] )
      @element = Usuario.new( email: params["usuario"]["email"], password: params["usuario"]["password"], token: params["usuario"]["token"])
      if ( @element != nil ) && ( !@element.save )
        @element = nil
      end
    else
      @element = nil
    end
    result(usuarios_path,@element)
  end

  def edit
    p "Edit"
    @element = Usuario.find(params[:id]) rescue nil
  end

  def update
    nota = ""
    if ( params["usuario"]["password"] == params["usuario"]["password_confirm"] )
      @element = Usuario.find(params[:id]) rescue nil
      if ( @element != nil )
        if ( params["usuario"]["password"] != nil && params["usuario"]["password"] != "" )
          if ( !@element.update( password: params["usuario"]["password"] ) )
            @element = nil
            nota = "Password couldn't be updated"
          end
        end
      end

      if ( @element != nil )
        if ( params["usuario"]["admin"] != nil )
          if ( !@element.update( admin: params["usuario"]["admin"] ) )
            @element = nil
          end
        end
      end

      if ( @element != nil )
        if ( params["usuario"]["email"] != nil )
          if ( !(@element.update( email: params["usuario"]["email"] ) rescue false ) )
            @element = nil
            nota = "Email couldn't be updated"
          end
        end
      end

    else
      @element = nil
    end
    result(usuarios_path,@element, nota)
  end

  def destroy
    p "Destroy"
    @element = Usuario.find(params[:id]) rescue nil
    if ( @element != nil ) && ( !@element.destroy )
      @element = nil
    end
    result(usuarios_path,@element)
  end

  def raiz
    p "raiz"
    result(nil,{result: "OK"})
  end

  def login
    nota = ""
    p "Login"
    p params["usuario"]["email"]
    p params["usuario"]["password"]

    element = Usuario.where(["email = :email and password = :password", { email: params["usuario"]["email"], password: params["usuario"]["password"] }] ).first rescue nil

    session.clear
    if element != nil
      p element.email
      p element.password
      session[:usuario_id] = params["usuario"]["email"]
      session[:usuario_token] = SecureRandom.hex(16)
    else
      p "nil"
      nota = "Invalid email/password"
    end



    p "Sign in 2"
    p session[:usuario_id]
    p session[:usuario_token]


    if ( ( element != nil ) && ( !element.update( token: session[:usuario_token] ) ) )
      element = nil
      session.clear
    end
    result(nil,element,nota)
  end

  def salir
    p "Salir"
    
    token = session[:usuario_token]
    if ( token == nil )
      token = request.headers[:authorization]      
    end

    element = Usuario.where(["token = :token", { token: token }] ).first rescue nil

    session.clear

    p "Sign out"
    p token
    p session[:usuario_id]
    p session[:usuario_token]

    if ( element != nil && !element.update( token: "" ) )
        element = nil
    end

    result(root_path,element)
  end

end
