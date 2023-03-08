# frozen_string_literal: true

class Phone < ApplicationRecord
  enum :verification_status, {
    in_progress: 'in_progress',
    succeeded: 'succeeded',
    failed: 'failed'
  }, default: 'in_progress', prefix: true

  belongs_to :user

  validates :number, presence: true, uniqueness: { scope: [:code] }
end
