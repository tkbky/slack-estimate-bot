Rails.application.routes.draw do

  resource :oauth, only: [:show]

  namespace :api do
    resource :estimate, only: [:create]
  end

  root 'pages#landing'

end
