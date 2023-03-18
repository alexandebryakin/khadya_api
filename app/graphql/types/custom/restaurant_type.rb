# frozen_string_literal: true

module Types
  module Custom
    class RestaurantType < ::Types::BaseObject
      field :id, ID, null: false
      field :name, String, null: false
      field :currency_code, String, null: false
      field :images, [Types::Custom::AttachmentType], null: false
    end
  end
end
