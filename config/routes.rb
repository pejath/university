Rails.application.routes.draw do

  resources :subjects
  resources :lecturers
  resources :lecturers_subjects, only: %i[new create]

  resources :groups do
    resources :lectures
  end
  resources :students


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
