class EstacionamientoController < PlantillaController

  def busqueda_dueno
	Rails.logger.debug("--------------> cargando busqueda" );
  end
  
  def busqueda_dueno_post
    
    render "busqueda"
  end

  def busqueda_cliente
    Rails.logger.debug("--------------> cargando busqueda" );
  end
    
  def busqueda_cliente_post
      
      render "busqueda"
  end

end