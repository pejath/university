Rails.application.routes.draw do
  root 'faculties#index'

  resources :subjects, :lecturers
  resources :students
  resources :lecturers_subjects, only: %i[destroy new create]

  resources :faculties do
    resources :departments
  end

  resources :groups do
    resources :lectures
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
