require File.join(Rails.root, "app", "models", "Usuario.rb")

class SeguridadController < ApplicationController

  def login
  cookies.delete(:id_usuario)
  cookies.delete(:nombre_usuario)
  cookies.delete(:perfil_usuario)
	Rails.logger.debug("--------------> cargando login" );
  end
  
  def login_post
    @usuario = params[:ccod_usu]   
    @contrasena = params[:cpass_usu]
    
    Rails.logger.debug("--------------> " + @usuario)
    Rails.logger.debug("--------------> " + @contrasena)

    @usuarios = Usuario.find_by_sql("SELECT * FROM usuario where correo ='"+@usuario+"' and contrasenia='"+@contrasena+"'")
    
    if @usuarios.nil?
        Rails.logger.debug("--------------> esta vacio!... ")
        @resultado = "Usuario o password inválidos"
    else
      usr = nil
        @usuarios.each do |p|
          usr = p
          cookies[:id_usuario] = usr.IdUsuario.to_i
          cookies[:nombre_usuario] = usr.Nombres.to_s
          cookies[:perfil_usuario] = usr.TipoUsuario.to_s
         # Rails.logger.debug("sesion--------------> " + usr.Nombres.to_s)
        end
       if usr == nil
        @resultado = "Usuario o password inválidos"
       end
    end 

    if usr == nil
       render "login"
    else
       redirect_to '/estacionamiento/busqueda_cliente'
    end

  end

end
