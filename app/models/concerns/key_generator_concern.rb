# frozen_string_literal: true
require 'securerandom'
module KeyGeneratorConcern extend ActiveSupport::Concern
  ##
  # Generate and persist a KeyToken with a random alphanumeric value of the given length.
  # Retries key generation until the record is successfully saved.
  # @param [Integer] key_size - The length of the generated alphanumeric key.
  # @return [KeyToken] The persisted KeyToken with `key_value` set.
  def generate_key_value(key_size)
    key = KeyToken.new
    until KeyToken.save
      key.key_value = SecureRandom.alphanumeric(key_size)
    end
    key
  end

  ##
  # Generates the specified number of key tokens, each with the given length.
  # @param [Integer] number_of_keys - The number of keys to create.
  # @param [Integer] batch_size - The length in characters of each generated key.
  # @return [Integer] The value of `number_of_keys` (the number of iterations performed).
  def batch_generate_key_value(number_of_keys,batch_size)
    number_of_keys.times do
      generate_key_value(batch_size)
    end
  end

  ##
  # Retrieves an unused KeyToken and marks it as used with the current timestamp.
  # @return [KeyToken, nil] The updated KeyToken with `is_used` set to true and `used_at` set to the current time, or `nil` if no unused token is available.
  def get_key
    KeyToken.where(is_used: false).find_one_and_update(
        { '$set': { is_used: true, used_at: Time.current } },
        return_document: :after
      )
  end

end