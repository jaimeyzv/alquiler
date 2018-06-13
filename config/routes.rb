Rails.application.routes.draw do
  get 'usuario/tipousuario'
  get 'usuario/mantenimiento'

  get 'seguridad/login'
  post 'seguridad/login_post'

  get 'estacionamiento/busqueda_dueno'
  post 'estacionamiento/busqueda_dueno_post'

  get 'estacionamiento/busqueda_cliente'
  post 'estacionamiento/busqueda_cliente_post'

  get 'estacionamiento/mantenimiento'
  post 'estacionamiento/mantenimiento_post'

  get 'estacionamiento/alquiler_estacionamiento'
  post 'estacionamiento/alquiler_estacionamiento_post'

 # get 'formularios/ejercicio3'
 # post 'formularios/ejercicio3_post'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end