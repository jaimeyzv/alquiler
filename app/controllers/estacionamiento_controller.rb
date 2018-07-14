require File.join(Rails.root, "app", "models", "Distrito.rb")
require File.join(Rails.root, "app", "models", "Estacionamiento.rb")
require File.join(Rails.root, "app", "models", "EstacionamientoComentario.rb")
require File.join(Rails.root, "app", "models", "Servicioadicional.rb")
require File.join(Rails.root, "app", "models", "TipoEstacionamiento.rb")
require File.join(Rails.root, "app", "models", "Estacionamientoxalquiler.rb")
require File.join(Rails.root, "app", "models", "Estacionamientoalquilerservicioadicional.rb")

class EstacionamientoController < PlantillaController

  def busqueda_dueno
    @estacionamientos  = Estacionamiento.find_by_sql(
    "SELECT	E.*, D.Nombre AS 'NombreDistrito', TE.Nombre AS 'NombreTipoEstacionamiento'
    FROM	  Estacionamiento E INNER JOIN Distrito D
            ON E.IdDistrito = D.IdDistrito
            INNER JOIN TipoEstacionamiento TE
            ON E.IdTipoEstacionamiento = TE.IdTipoEstacionamiento
    WHERE	IdUsuario = " + cookies[:id_usuario].to_s )

  	Rails.logger.debug("--------------> cargando busqueda" );
  end
  
  def busqueda_dueno_post
    @txt_nombre     = params[:txt_nombre]
    @estacionamientos  = Estacionamiento.find_by_sql("
    SELECT	E.*, D.Nombre AS 'NombreDistrito', TE.Nombre AS 'NombreTipoEstacionamiento'
    FROM	Estacionamiento E INNER JOIN Distrito D
		ON    E.IdDistrito = D.IdDistrito
          INNER JOIN TipoEstacionamiento TE
          ON E.IdTipoEstacionamiento = TE.IdTipoEstacionamiento
    WHERE	IdUsuario = " + cookies[:id_usuario] + " AND E.Nombre LIKE '%" + @txt_nombre + "%'")

    render "busqueda_dueno"
  end

  def busqueda_cliente
    @distritos    = Distrito.find_by_sql("SELECT * FROM Distrito ORDER BY Nombre ASC")
    @tipoEstacionamientos = TipoEstacionamiento.find_by_sql("SELECT	* FROM	TipoEstacionamiento ORDER BY Nombre ASC;")
    @estacionamientos = Estacionamiento.find_by_sql("select * from estacionamiento ORDER BY IdEstacionamiento ASC")
    
    puts @txt_precio_desde.inspect
  end
    
  def busqueda_cliente_post
    @distritos        = Distrito.find_by_sql("SELECT * FROM Distrito ORDER BY Nombre ASC")
    @tipoEstacionamientos = TipoEstacionamiento.find_by_sql("SELECT	* FROM	TipoEstacionamiento ORDER BY Nombre ASC;")
    @sel_distrito     = params[:sel_distrito]
    @sel_tipo_estacionaminto    = params[:sel_tipo_estacionaminto]
    @txt_precio_desde = params[:txt_precio_desde]
    @txt_precio_hasta = params[:txt_precio_hasta]
    @txt_puntuacion   = params[:txt_puntuacion]
    @chck_puntos_todos  = params[:chck_puntos_todos]

    if (@chck_puntos_todos != nil)
      @estacionamientos  = Estacionamiento.find_by_sql(
      "SELECT TB.*
      FROM
      (
        SELECT  E.*, IFNULL(EC.Puntuacion, 0) AS 'Puntuacion'
        FROM	  Estacionamiento E LEFT JOIN EstacionamientoComentario EC
                ON E.IdEstacionamiento = EstacionamientoComentario_IdEstacionamientoComentario
      ) AS TB
      WHERE	  IdDistrito = " + @sel_distrito + "
              AND IdTipoEstacionamiento = " + @sel_tipo_estacionaminto + "
              AND PrecioPorHora Between " + @txt_precio_desde + " AND " + @txt_precio_hasta )  
    else
      @estacionamientos  = Estacionamiento.find_by_sql(
        "SELECT TB.*
        FROM
        (
          SELECT  E.*, IFNULL(EC.Puntuacion, 0) AS 'Puntuacion'
          FROM	  Estacionamiento E LEFT JOIN EstacionamientoComentario EC
                  ON E.IdEstacionamiento = EstacionamientoComentario_IdEstacionamientoComentario
        ) AS TB
        WHERE	  IdDistrito = " + @sel_distrito + "
                AND IdTipoEstacionamiento = " + @sel_tipo_estacionaminto + "
                AND PrecioPorHora Between " + @txt_precio_desde + " AND " + @txt_precio_hasta + "
                AND Puntuacion = " + @txt_puntuacion)
    end

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
    where esa.IdEstacionamiento=" + @idEstacion)
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
    @txt_fecha_desde  = params[:txt_fecha_desde]
    @txt_fecha_hasta  = params[:txt_fecha_hasta]

    @estacionamientos  = Estacionamiento.find_by_sql(
      "SELECT	E.*
      FROM	EstacionamientoxAlquiler EXA INNER JOIN ESTACIONAMIENTO E
            ON EXA.IdEstacionamiento = E.IdEstacionamiento");


  end

  def busqueda_alquilados_post
    @txt_fecha_desde  = params[:txt_fecha_desde]
    @txt_fecha_hasta  = params[:txt_fecha_hasta]

    @estacionamientos  = Estacionamiento.find_by_sql(
      "SELECT	E.*
      FROM	EstacionamientoxAlquiler EXA INNER JOIN ESTACIONAMIENTO E
          ON EXA.IdEstacionamiento = E.IdEstacionamiento
      WHERE	EXA.FechaInicio >= '" + @txt_fecha_desde + "' AND EXA.FechaFin <= '" + @txt_fecha_hasta +"';"
    );

    render 'buscar_alquilados'
  end

end