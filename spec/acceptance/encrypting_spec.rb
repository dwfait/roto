require 'spec_helper'

describe 'Encrypting JSON' do
  let(:json) do
    { name: 'John Smith',
      age: '42',
      gender: 'male' }
  end
  let(:cipher_key) { 'DB5E8D7DD93F4633F1838E5E73BA9' }
  let(:hmac_key) { '8DC83DF63ADAA34487F2F73D78846' }

  specify 'I can encrypt the JSON string' do
    encryptor = Roto::Encryptor.new(cipher_key, hmac_key)
    expect(encryptor.encrypt(json)).to_not be_nil
  end
end
