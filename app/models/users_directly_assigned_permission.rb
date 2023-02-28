# frozen_string_literal: true

class UsersDirectlyAssignedPermission < ApplicationRecord
  belongs_to :user
  belongs_to :permission
end
