# frozen_string_literal: true

class BaseMutation < GraphQL::Schema::Mutation
  field :status, Types::StatusType
  field :errors, GraphQL::Types::JSON

  private

  # @return [User]
  def current_user
    context[:current_user]
  end

  def status_success
    Types::StatusType::SUCCESS
  end

  def status_failure
    Types::StatusType::FAILURE
  end

  def success(args = {})
    {
      status: status_success,
      errors: {},
      **args
    }
  end

  def failure(args = {})
    {
      status: status_failure,
      **args
    }
  end
end
