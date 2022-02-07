Rails.application.routes.draw do

  resources :lecture_times
  # resources :lecturers
  resources :students

  resources :lecture_times, via: :show
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
