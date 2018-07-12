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
    
    puts @txt_precio_desde.inspect
  end
    
  def busqueda_cliente_post
    @distritos        = Distrito.find_by_sql("SELECT * FROM Distrito ORDER BY Nombre ASC")
    @sel_distrito     = params[:sel_distrito]
    @sel_ubicacion    = params[:sel_ubicacion]
    @txt_precio_desde = params[:txt_precio_desde]
    @txt_precio_hasta = params[:txt_precio_hasta]
    @txt_puntuacion   = params[:txt_puntuacion]

    puts @txt_precio_desde.inspect

    @estacionamientos = Estacionamiento.joins('INNER JOIN Distrito')
                        .where('Estacionamiento.IdDistrito = ' + @sel_distrito + ' AND Estacionamiento.IdUbicacion = ' + @sel_ubicacion + ' AND Estacionamiento.PrecioPorHora Between ' + @txt_precio_desde + ' AND ' + @txt_precio_hasta).uniq;

    puts @estacionamientos.inspect

    estacionamiento = Estacionamiento.first
    #puts estacionamiento.inspect
    #estacionamiento.distrito # returns prod1's category
    distrito = Distrito.first
    #puts distrito.inspect
    #distrito.estacionamientos #returns collection of cat1's products

    render "busqueda_cliente"
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