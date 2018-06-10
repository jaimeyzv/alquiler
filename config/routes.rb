Rails.application.routes.draw do
  get 'seguridad/login'
  post 'seguridad/login_post'

  get 'estacionamiento/busqueda'
  post 'estacionamiento/busqueda_post'
  
 # get 'formularios/ejercicio3'
 # post 'formularios/ejercicio3_post'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
