require 'spec_helper'

describe 'Encrypting JSON' do
  let(:json) do
    { name: 'John Smith',
      age: '42',
      gender: 'male' }
  end

  specify 'I can encrypt the JSON string' do
    encryptor = Roto::Encryptor.new(test_cipher_key, test_hmac_key)
    expect(encryptor.encrypt(json)).to_not be_nil
  end
end
