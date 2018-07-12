require File.join(Rails.root, "app", "models", "Distrito.rb")
require File.join(Rails.root, "app", "models", "Estacionamiento.rb")
require File.join(Rails.root, "app", "models", "EstacionamientoComentario.rb")

class EstacionamientoController < PlantillaController

  def busqueda_dueno
	Rails.logger.debug("--------------> cargando busqueda" );
  end
  
  def busqueda_dueno_post
    
    render "busqueda"
  end

  def busqueda_cliente
    @distritos    = Distrito.find_by_sql("SELECT * FROM Distrito ORDER BY Nombre ASC")
    @estacionamientos = Estacionamiento.find_by_sql("select * from estacionamiento ORDER BY IdEstacionamiento ASC")
    #@estacionamientos = Estacionamiento.includes(:estacionamientocomentarios).uniq
  end
    
  def busqueda_cliente_post
      
      render "busqueda"
  end

  def alquiler
    Rails.logger.debug("--------------> cargando alquiler" );
    @idEstacion = params[:id] 
    @estacionamientos = Estacionamiento.find_by_sql("select * from estacionamiento where IdEstacionamiento=" + @idEstacion)
    
    @estacionamientos.each do |p|
          @estacionamiento = p
    end

  end
    
  def alquiler_post
      
      render "alquiler"
  end

  def buscar_alquilados
  end

end