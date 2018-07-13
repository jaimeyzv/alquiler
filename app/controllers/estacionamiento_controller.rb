require File.join(Rails.root, "app", "models", "Distrito.rb")
require File.join(Rails.root, "app", "models", "Estacionamiento.rb")
require File.join(Rails.root, "app", "models", "EstacionamientoComentario.rb")
require File.join(Rails.root, "app", "models", "Servicioadicional.rb")
require File.join(Rails.root, "app", "models", "Estacionamientoxalquiler.rb")
require File.join(Rails.root, "app", "models", "Estacionamientoalquilerservicioadicional.rb")

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

    @serviciosAdicionales = Servicioadicional.find_by_sql("select * from servicioadicional sa 
inner join estacionamientoservicioadicional esa on sa.IdServicioAdicional=esa.IdServicioAdicional
where esa.IdEstacionamiento="+@idEstacion)


  end
    
  def alquiler_post
      
      Rails.logger.debug("--------------> alquiler post " );

      @idEstacion = params[:id]
      @adicionales = params[:adicionales]
      @txt_fecha_ini   = params[:txt_fecha_ini] 
      @txt_fecha_fin   = params[:txt_fecha_fin] 

      @fecha_formateada1 = Date.strptime(@txt_fecha_ini, '%d/%m/%Y')
      @fecha_formateada2 = Date.strptime(@txt_fecha_fin, '%d/%m/%Y')

      @estacionamiento = nil
      total = 0

      @adicionales.map { |m| 
        @serviciosAdicionales = Servicioadicional.find_by_sql("select * from servicioadicional sa 
          inner join estacionamientoservicioadicional esa on sa.IdServicioAdicional=esa.IdServicioAdicional
          inner join estacionamiento esta on esa.IdEstacionamiento=esta.IdEstacionamiento
          where esa.IdEstacionamiento="+@idEstacion + " and esa.IdServicioAdicional="+ m)

        @serviciosAdicionales.each do |p|
          @estacionamiento = p
          total = total + p.tarifaAdicional.to_f
        end
      }

      total = total + @estacionamiento.PrecioPorHora

      nuevoAlquiler = Estacionamientoxalquiler.new(:FechaInicio => @fecha_formateada1.to_date,
        :FechaFin => @fecha_formateada2.to_date,
        :PrecioTotal => total.to_f,
        :FechaRegistro => Date.today,
        :IdEstacionamiento => @estacionamiento.IdEstacionamiento.to_i,
        :Usuario_IdUsuario => 1)

      nuevoAlquiler.save

      # falta cargar id del nuevo alquiler en IdEstacionamiento
      @adicionales.map { |m| 
        @serviciosAdicionales = Servicioadicional.find_by_sql("select * from servicioadicional sa 
          inner join estacionamientoservicioadicional esa on sa.IdServicioAdicional=esa.IdServicioAdicional
          inner join estacionamiento esta on esa.IdEstacionamiento=esta.IdEstacionamiento
          where esa.IdEstacionamiento="+@idEstacion + " and esa.IdServicioAdicional="+ m)

        @serviciosAdicionales.each do |p|
          nuevoServicio = Estacionamientoalquilerservicioadicional.new(:IdServicioAdicional => p.IdServicioAdicional.to_i,
            :AlquilerEstacionamiento_IdAlquilerEstacionamiento => p.IdEstacionamiento.to_i)
          nuevoServicio.save
        end
      }



      @estacionamientos = Estacionamiento.find_by_sql("select * from estacionamiento where IdEstacionamiento=" + @idEstacion)
      @estacionamientos.each do |p|
          @estacionamiento = p
      end

      @serviciosAdicionales = Servicioadicional.find_by_sql("select * from servicioadicional sa 
        inner join estacionamientoservicioadicional esa on sa.IdServicioAdicional=esa.IdServicioAdicional
        where esa.IdEstacionamiento="+@idEstacion)

      #render "alquiler"
      redirect_to '/estacionamiento/busqueda_cliente'
  end

  def buscar_alquilados
  end

end