require 'roto'

def test_cipher_key
  'DB5E8D7DD93F4633F1838E5E73BA9'
end

def test_hmac_key
  '8DC83DF63ADAA34487F2F73D78846'
end

def test_encryptor
  Roto::Encryptor.new(test_cipher_key, test_hmac_key)
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
