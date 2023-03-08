# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  scope module: 'public_api' do
    get  '/public/anonymous_user/new', to: 'anonymous_user#new'
    post '/public/graphql_schema', to: 'graphql_schema#graphql_schema'
  end

  post '/graphql', to: 'graphql#execute'
end
