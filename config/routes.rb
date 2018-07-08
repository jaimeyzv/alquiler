Rails.application.routes.draw do
  get 'publicidad/mantenimiento'

  get 'usuario/tipousuario'
  get 'usuario/mantenimiento'
  post 'usuario/mantenimiento_post'

  get 'seguridad/login'
  post 'seguridad/login_post'

  get 'estacionamiento/busqueda_dueno'
  post 'estacionamiento/busqueda_dueno_post'

  get 'estacionamiento/busqueda_cliente'
  post 'estacionamiento/busqueda_cliente_post'

  get 'estacionamiento/mantenimiento'
  post 'estacionamiento/mantenimiento_post'

  get 'estacionamiento/alquiler'
  post 'estacionamiento/alquiler_post'

  get 'estacionamiento/buscar_alquilados'
end