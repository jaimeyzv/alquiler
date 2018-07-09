require File.join(Rails.root, "app", "models", "Usuario.rb")

class UsuarioController < ApplicationController
  @@tipo_documentos = Usuario.find_by_sql("SELECT * FROM TipoDocumento")

  def tipousuario
    
  end

  def mantenimiento
    @tipo_documentos = Usuario.find_by_sql("SELECT * FROM TipoDocumento")
  end

  def mantenimiento_post
    @tipo_documentos    = Usuario.find_by_sql("SELECT * FROM TipoDocumento")
    @resultado          = ''
    @txt_nombre         = params[:txt_nombre] 
    @txt_ape_pat        = params[:txt_ape_pat] 
    @txt_ape_mat        = params[:txt_ape_mat] 
    @sel_sexo           = params[:sel_sexo] 
    @sel_tipo_doc       = params[:sel_tipo_doc] 
    @txt_num_doc        = params[:txt_num_doc] 
    @sel_tipo_usuario   = params[:sel_tipo_usuario] 
    @txt_correo         = params[:txt_correo] 
    @txt_fecha_nac      = params[:txt_fecha_nac] 
    @txt_celular        = params[:txt_celular] 
    @txt_password       = params[:txt_password] 
    @txt_confirmar_password = params[:txt_confirmar_password] 

    @fecha_formateada = Date.strptime(@txt_fecha_nac, '%m/%d/%Y')
    
    if (!es_password_valido(@txt_password, @txt_confirmar_password))
      @resultado = 'Las contraseñas no son iguales.'
      render 'mantenimiento'
      return
    end

    usuario =  Usuario.new(:TipoUsuario => @sel_tipo_usuario,
                           :Nombres => @txt_nombre,
                           :ApellidoPaterno => @txt_ape_pat,
                           :ApellidoMaterno => @txt_ape_mat,
                           :Sexo => @sel_sexo,
                           :Correo => @txt_correo,
                           :Contrasenia => @txt_password,
                           :FechaNacimiento => @fecha_formateada.to_date,
                           :Celular => @txt_celular,
                           :FechaRegistro => Date.today,
                           :TipoDocumento_IdTipoDocumento => @sel_tipo_doc)
    usuario.save

    redirect_to '/estacionamiento/busqueda_cliente'
  end

  def es_password_valido(password, confirmar_password)
    return password == confirmar_password
  end
end
