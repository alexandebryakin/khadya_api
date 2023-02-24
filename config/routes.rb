# frozen_string_literal: true

Rails.application.routes.draw do
  post '/graphql', to: 'graphql#execute'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  scope module: 'public_api' do
    post '/public/graphql', to: 'graphql#execute'
  end

  scope module: 'private_api' do
    post '/private/graphql', to: 'graphql#execute'
  end

  post '/graphql_schema', to: 'graphql_schema#graphql_schema'
end
