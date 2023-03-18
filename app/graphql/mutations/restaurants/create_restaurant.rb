# frozen_string_literal: true

module Mutations
  module Restaurants
    class CreateRestaurant < BaseMutation
      argument :name, String, required: true

      field :network, Types::Custom::NetworkType, null: true
      field :restaurant, Types::Custom::RestaurantType, null: true

      def resolve(name:)
        network = Network.find_or_initialize_by(user: current_user)
        network.update!(name:) if network.new_record?

        restaurant = network.restaurants.new(name:)

        return success(network:, restaurant:) if restaurant.save

        failure(errors: restaurant.errors.messages)
      end
    end
  end
end
