# frozen_string_literal: true

class KeyToken
  include Mongoid::Document
  include Mongoid::Timestamps

  field :key_value,  type: String
  field :is_used, type: Boolean

  validates :key_value, presence: true, uniqueness: true

  index({ key_value: 1 }, { unique: true, background: true })
end
