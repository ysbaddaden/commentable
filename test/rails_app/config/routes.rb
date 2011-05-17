RailsApp::Application.routes.draw do
  resources :posts, :only => [:show, :index] do
    resources :comments
  end
  
  resources :pages, :only => [:show, :index] do
    resources :comments
  end
  
  root :to => "home#index"
end
