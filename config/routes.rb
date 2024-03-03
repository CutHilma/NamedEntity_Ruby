Rails.application.routes.draw do
  resources :svm_models, only: [] do
    collection do
      get 'train'
      post 'predict'
    end
  end

  root 'svm_models#train'
  post '/svm_models/predict', to: 'svm_models#predict'
  get '/svm_models/predict', to: 'svm_models#predict'

end
