# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::Auth::SigninUser, type: :request do
  subject(:run_mutation) { post('/graphql', params:) }

  let(:query) do
    <<~GRAPHQL
      mutation SigninUser($email: String!, $password: String!){
        signinUser(email: $email, password: $password) {
          user {
            id
            emails {
              email
            }
          }
          token
          errors
        }
      }
    GRAPHQL
  end
  let(:params) do
    {
      query:,
      variables:
    }
  end

  let(:response_body) { JSON.parse(response.body) }

  let!(:user) { create(:user, password: '1234') }
  let!(:email) { create(:email, user:, email: 'usr@mail.com') }

  before do
    run_mutation
  end

  context 'with valid data' do
    let(:variables) do
      {
        email: email.email,
        password: user.password
      }
    end
    let(:expected_token) do
      Auth::JwtEncode.new.call(
        data: {
          user: {
            id: user.id
          }
        }
      )
    end

    it 'signs in a user' do
      expect(response_body.dig('data', 'signinUser', 'token')).to eq(expected_token)
    end

    it 'returns user attributes' do
      expect(response_body.dig('data', 'signinUser', 'user')).to eq(
        'id' => user.id,
        'emails' => [{ 'email' => email.email }]
      )
    end

    it 'returns no errors' do
      expect(response_body.dig('data', 'signinUser', 'errors')).to eq({})
    end
  end

  context 'with blank credentials' do
    let(:variables) do
      {
        email: '',
        password: ''
      }
    end

    it 'does not return a token' do
      expect(response_body.dig('data', 'signinUser', 'token')).to be_nil
    end

    it 'does not return a user' do
      expect(response_body.dig('data', 'signinUser', 'user')).to be_nil
    end

    it 'returns errors saying that credentials are blank' do
      expect(response_body.dig('data', 'signinUser', 'errors')).to eq(
        'email' => [Public::Mutations::Auth::SigninUser::CANT_BE_BLANK],
        'password' => [Public::Mutations::Auth::SigninUser::CANT_BE_BLANK]
      )
    end
  end

  context 'when no user found' do
    let(:variables) do
      {
        email: 'non-existing-user@mail.com',
        password: 'abc'
      }
    end

    it 'return an error' do
      expect(response_body.dig('data', 'signinUser', 'errors')).to eq(
        'user' => [Public::Mutations::Auth::SigninUser::NOT_FOUND]
      )
    end
  end

  context 'when invalid credentials' do
    let(:variables) do
      {
        email: email.email,
        password: "#{user.password}invalid-pwd-postfix"
      }
    end

    it 'return an error' do
      expect(response_body.dig('data', 'signinUser', 'errors')).to eq(
        'user' => [Public::Mutations::Auth::SigninUser::INVALID_CREDENTIALS]
      )
    end
  end
end
