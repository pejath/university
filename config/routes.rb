# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions', registrations: 'registrations' },
                     path_names: { sign_in: :login, sign_out: :logout }
  root 'faculties#index'
  get :profile, controller: 'users'
  resources :subjects, :lecturers
  resources :students
  resources :lecturers_subjects, only: %i[destroy new create]

  resources :faculties do
    resources :departments
  end

  resources :groups do
    resources :lectures
    get 'journal', to: 'groups#journal' # { groups: 'groups' }
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
