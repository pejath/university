Rails.application.routes.draw do

  resources :lecturers
  resources :lecturers_subjects, only: %i[destroy new create]
  resources :students
  resources :lecture_times, only: :index
  
  resources :groups do
    resources :lectures
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
