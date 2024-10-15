# frozen_string_literal: true

class Vote < ApplicationRecord
  belongs_to :tierlistitem

  enum vote_type: { up: 0, stay: 1, down: 2 }
end
