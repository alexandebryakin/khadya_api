# frozen_string_literal: true

module Mutations
  module Restaurants
    class RemoveRestaurantAttachment < BaseMutation
      argument :restaurant_id, ID, required: true
      argument :attachment_id, ID, required: true
      argument :attachment_type, Types::Custom::RestaurantAttachmentTypeEnum,
               default_value: Types::Custom::RestaurantAttachmentTypeEnum::IMAGE,
               replace_null_with_default: true, required: false

      field :restaurant, Types::Custom::RestaurantType, null: false

      def resolve(restaurant_id:, attachment_id:, attachment_type:)
        restaurant = current_user.restaurants.find(restaurant_id)

        restaurant_attachments = {
          Types::Custom::RestaurantAttachmentTypeEnum::IMAGE => restaurant.images
        }.fetch(attachment_type)

        restaurant_attachments.find(attachment_id).purge

        success(restaurant:)
      end
    end
  end
end
