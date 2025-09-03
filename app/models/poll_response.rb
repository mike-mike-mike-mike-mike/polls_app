# frozen_string_literal: true

class PollResponse < ApplicationRecord
  belongs_to :poll
  validates :answer, presence: true
end
