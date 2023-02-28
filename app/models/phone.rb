# frozen_string_literal: true

class Phone < ApplicationRecord
  VERIFICATION_STATUSES = {
    in_progress: 'in_progress',
    succeeded: 'succeeded',
    failed: 'failed'
  }.freeze

  enum :verification_status, VERIFICATION_STATUSES, _default: 'in_progress'

  belongs_to :user

  validates :number, presence: true, uniqueness: { scope: [:code] }
end
