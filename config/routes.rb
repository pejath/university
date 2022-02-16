Rails.application.routes.draw do

  resources :subjects, :lecturers do
    member do
      get :destroy_subject
      post :destroy_subject
    end
  end
  # resources :lecturers do
  #   member do
  #     get :destroy_subject
  #     post :destroy_subject
  #   end
  # end
  resources :lecturers_subjects, only: %i[destroy new create]

  resources :groups do
    resources :lectures
  end
  resources :students


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
