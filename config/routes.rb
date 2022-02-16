Rails.application.routes.draw do

  resources :students
  resources :lecturers_subjects, only: %i[destroy new create]

  resources :faculties do
    resources :departments
  end

  resources :subjects, :lecturers do
    member do
      get :destroy_subject
      post :destroy_subject
    end
  end

  resources :groups do
    resources :lectures
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
