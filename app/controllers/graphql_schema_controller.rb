# frozen_string_literal: true

class GraphqlSchemaController < ApplicationController
  def graphql_schema
    graphql_schema_relative_path = "app/graphql/#{params[:scope]}/generated_schemas/schema.json"

    schema = File.open(Rails.root.join(graphql_schema_relative_path))

    render(json: JSON.parse(schema.read))
  end
end
