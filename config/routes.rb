Rails.application.routes.draw do
  get 'usuario/tipousuario'

  get 'seguridad/login'
  post 'seguridad/login_post'

  get 'estacionamiento/busqueda'
  post 'estacionamiento/busqueda_post'

  get 'estacionamiento/mantenimiento'
  post 'estacionamiento/mantenimiento_post'

 # get 'formularios/ejercicio3'
 # post 'formularios/ejercicio3_post'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
