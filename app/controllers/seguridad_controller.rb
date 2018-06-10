class SeguridadController < ApplicationController

  def login
	Rails.logger.debug("--------------> cargando login" );
  end
  
  def login_post
    @txt_nombre_producto = params[:txt_nombre_producto]   
    @num_precio_producto = params[:num_precio_producto]
    
    Rails.logger.debug("--------------> " + @txt_nombre_producto)
    Rails.logger.debug("--------------> " + @num_precio_producto)
    
    render "login"
  end

end
