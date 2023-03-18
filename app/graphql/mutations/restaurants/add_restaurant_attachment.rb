# frozen_string_literal: true

module Mutations
  module Restaurants
    class AddRestaurantAttachment < BaseMutation
      argument :restaurant_id, ID, required: true
      argument :attachment, ApolloUploadServer::Upload, required: true
      argument :attachment_type, Types::Custom::RestaurantAttachmentTypeEnum,
               default_value: Types::Custom::RestaurantAttachmentTypeEnum::IMAGE,
               replace_null_with_default: true,
               required: false

      field :restaurant, Types::Custom::RestaurantType, null: false

      def resolve(restaurant_id:, attachment:, attachment_type:) # rubocop:disable Metrics/MethodLength
        restaurant = current_user.restaurants.find(restaurant_id)

        image = ActiveStorage::Blob.create_and_upload!(
          io: attachment,
          filename: attachment.original_filename,
          content_type: attachment.content_type
        )

        restaurant_attachments = {
          Types::Custom::RestaurantAttachmentTypeEnum::IMAGE => restaurant.images
        }.fetch(attachment_type)

        restaurant_attachments.attach(image)

        # not sure if this works
        restaurant.valid? ? success(restaurant:) : failure(restaurant:, errors: restaurant.errors.messages)
      end
    end
  end
end
