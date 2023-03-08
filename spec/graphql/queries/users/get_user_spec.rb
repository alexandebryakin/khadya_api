# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Queries::Users::GetUser, type: :request do
  subject(:run_query) { KhadyaApiSchema.execute(query, variables:, context: { current_user: user }) }

  let(:user) { create(:user) }
  let(:query) do
    <<~GRAPHQL
      query GetUser($userId: ID!) {
        user(userId: $userId) {
          id
          phones {
            id
            number
          }
        }
      }
    GRAPHQL
  end

  let(:query_result) { run_query.to_h }
  let(:data) { query_result.dig('data', 'user') }
  let(:variables) do
    {
      userId: user.id
    }
  end

  context 'with phones' do
    let!(:phones) { create_list(:phone, 2, user:) }

    it 'returns user with phones' do
      expect(data['phones']).to match_array(phones.map { _1.attributes.stringify_keys.slice('id', 'number') })
    end
  end
end
