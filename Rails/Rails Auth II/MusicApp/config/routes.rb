Rails.application.routes.draw do
  resources :bands, only: [:index, :create, :new, :edit, :show, :update, :destroy] do
    resources :albumns, only: :new
  end

  resources :users, only: [:new, :create, :show] do
    collection do
      get "activate"
    end
  end

  resources :albumns, only: [:create, :edit, :show, :update, :destroy] do
    resources :tracks, only: :new
  end

  resources :tracks, only: [:create, :edit, :show, :update, :destroy]
  resource :session, only: [:create, :destroy, :new]

  root to: redirect("/session/new")
end