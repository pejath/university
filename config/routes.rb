Rails.application.routes.draw do

  resources :lecturers
  get 'red_diplomas', to: 'students#red_diplomas'
  get '/journal/(:group)', to: 'students#journal'
  resources :students, only: %i[destroy create new edit show update], path: 'student'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
