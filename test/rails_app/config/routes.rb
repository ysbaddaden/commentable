RailsApp::Application.routes.draw do
  resources :posts, :only => [:show, :index] do
    commentable
  end
  
  resources :pages, :only => [:show, :index] do
    commentable
  end
  
  root :to => "home#index"
end
