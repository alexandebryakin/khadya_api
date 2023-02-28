# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user
  belongs_to :table_session
  belongs_to :check
  has_many :order_items, dependent: :destroy


  STATUSES = {
    initial: 'initial',
    in_progress: 'in_progress',
    ordered: 'ordered',
    cooking: 'cooking',
    delivering: 'delivering',
    extending: 'extending',
    waiting_paycheck: 'waiting_paycheck',
    payed: 'payed'
  }.freeze

  enum :statuses, STATUSES, _default: 'initial'
end
