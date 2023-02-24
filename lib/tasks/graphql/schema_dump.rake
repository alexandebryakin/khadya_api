# frozen_string_literal: true

namespace :graphql do # rubocop:disable Metrics/BlockLength
  task schema_dump: :environment do # rubocop:disable Metrics/BlockLength
    require 'graphql/rake_task'

    def output_dir(scope)
      "app/graphql/#{scope}/generated_schemas/"
    end

    schemas = [
      {
        scope: 'private',
        class: Private::KhadyaApiSchema
      },
      {
        scope: 'public',
        class: Public::KhadyaApiSchema
      }
    ]

    threads = schemas.map do |schema|
      Thread.new do
        GraphQL::RakeTask.new(
          schema_name: schema[:class].to_s,
          directory: output_dir(schema[:scope]),
          load_schema: lambda do |_task|
            require Rails.root.join('config/environment')
            schema[:class]
          end
        )
        Rake::Task['graphql:schema:dump'].invoke
      end
    end

    threads.each(&:join)
  end
end
