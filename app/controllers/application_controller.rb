class ApplicationController < ActionController::Base
  require 'json'

  #before_action :my_authentication, except: [:sign_in, :sign]
  protect_from_forgery unless: -> { request.format.json? }

  # def my_authentication
  #   unless ( ( session[:user_id] != nil ) || ( User.where( token: request.headers[:authorization] ).count > 0 ) )
	 #  respond_to do |format|
  #       format.html { 
  #         redirect_to root_path
  #       }
  #       format.json { 
  #         render :json => "", :status => :unauthorized
  #       }
  #     end
  #   end
  # end

  def result(outputHTML,outputJSON,nota="")
    respond_to do |format|
      format.html { 
        if (!session[:user_admin])
          redirect_to root_path, notice: nota
        elsif outputHTML != nil
          redirect_to outputHTML, notice: nota
        end      
      }
      format.json { 
        if outputJSON != nil
          render :json => outputJSON, :status => :ok
        else
          render :json => "", :status => :bad_request
        end
      }
    end
  end
end
