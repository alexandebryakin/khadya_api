# frozen_string_literal: true

class BaseMutation < GraphQL::Schema::Mutation
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
end
