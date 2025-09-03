# frozen_string_literal: true

class Poll < ApplicationRecord
  validates :title, :description, :options, presence: true
  serialize :options, type: Array, coder: JSON
end
