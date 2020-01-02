Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :mensajes
  resources :usuarios

  patch 'login' => 'usuarios#login'
  get 'salir' => 'usuarios#salir'
  get 'enviar' => 'mensajes#enviar'
  root "usuarios#raiz"
  get 'usuarios/raiz' => 'usuarios#raiz'

end
