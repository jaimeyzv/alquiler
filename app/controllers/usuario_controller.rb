class UsuarioController < ApplicationController
  def tipousuario
  end

  def mantenimiento_post
    redirect_to '/estacionamiento/busqueda_cliente'
  end
end
