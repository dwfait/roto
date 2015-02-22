require 'spec_helper'

describe 'decrypting' do
  let(:json) { { string: 'test' } }
  let(:encrypted) { test_encryptor.encrypt(json) }

  specify 'I can decrypt the encrypted ' do
    decryptor = Roto::Decryptor.new(test_cipher_key, test_hmac_key)
    decrypted = decryptor.decrypt(encrypted)
    expect(decrypted.to_s).to eq(json.to_s)
  end
end
