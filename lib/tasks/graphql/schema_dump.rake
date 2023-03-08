# frozen_string_literal: true

namespace :graphql do
  task schema_dump: :environment do
    require 'graphql/rake_task'

    GraphQL::RakeTask.new(
      schema_name: 'KhadyaApiSchema',
      directory: 'app/graphql/generated_schemas/',
      load_schema: lambda do |_task|
        require Rails.root.join('config/environment')
        KhadyaApiSchema
      end
    )
    Rake::Task['graphql:schema:dump'].invoke
  end
end
