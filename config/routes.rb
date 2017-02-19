Rails.application.routes.draw do

  resource :oauth, only: [:show]

  namespace :api do
    resource :estimate, only: [:create]
  end

  namespace :me do
    resource :dashboard, only: [:show]
  end

  root 'pages#landing'

end
