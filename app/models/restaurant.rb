# frozen_string_literal: true

class Restaurant < ApplicationRecord
  belongs_to :network
  has_one :menu, dependent: :destroy
  has_many :tables, dependent: :destroy
  has_many :restaurants_employees, dependent: :destroy
  has_many :employees, through: :restaurants_employees
end
