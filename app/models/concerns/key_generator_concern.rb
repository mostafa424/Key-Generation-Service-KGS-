# frozen_string_literal: true
require 'securerandom'
module KeyGeneratorConcern extend ActiveSupport::Concern
  def generate_key_value(key_size)
    key = nil
    while KeyToken.exists?(key_value: key&.key_value)
      key = SecureRandom.alphanumeric(key_size)
      KeyToken.create!(key)
    end
    key
  end

  def batch_generate_key_value(number_of_keys,batch_size)
    generate_key_value(batch_size)
  end

  def get_key
    KeyToken.where(is_used: false).find_one_and_update(
        { '$set': { is_used: true, used_at: Time.current } },
        return_document: :after
      )
  end

end
