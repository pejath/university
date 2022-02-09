Rails.application.routes.draw do

  get "/lecture_time", to: 'lecture_times#index'
  # resources :lecturers
  resources :students

  resources :lecture_times, via: :show
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
