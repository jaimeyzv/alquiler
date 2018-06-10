class EstacionamientoController < PlantillaController

  def busqueda
	Rails.logger.debug("--------------> cargando busqueda" );
  end
  
  def busqueda_post
    
    render "busqueda"
  end

end