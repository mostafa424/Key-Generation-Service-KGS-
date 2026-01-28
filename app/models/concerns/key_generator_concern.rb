# frozen_string_literal: true
require 'securerandom'
module KeyGeneratorConcern extend ActiveSupport::Concern
  def generate_key_value(key_size)
    key = KeyToken.new
    until key.save
      key.key_value = SecureRandom.alphanumeric(key_size)
    end
    key
  end

  def batch_generate_key_value(number_of_keys,key_size)
    keys = []
    number_of_keys.times do
      keys += [generate_key_value(key_size)]
    end
    keys
  end

  def get_key
    KeyToken.where(is_used: false).find_one_and_update(
        { '$set': { is_used: true, used_at: Time.current } },
        return_document: :after
      )
  end

end
