Rails.application.routes.draw do

  resource :oauth, only: [:show]

  root 'pages#landing'

end
