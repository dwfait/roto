require 'spec_helper'

describe Roto::Decryptor do
  subject { Roto::Decryptor.new(test_cipher_key, test_hmac_key) }

  let(:plain) { 'hello world' }
  let(:encrypted) do
    test_encryptor.encrypt(plain)
  end

  context 'valid cipher text' do
    it 'should decrypt successfully' do
      expect(subject.decrypt(encrypted)).to eq(plain)
    end
  end

  context 'cipher text tampered with' do
    it 'should throw an invalid hmac exception' do
      altered = encrypted.bytes
      altered[0] = (altered[0] + 1 % 255)
      expect { subject.decrypt(altered.to_s) }.
        to raise_exception(Roto::Errors::InvalidHMACError)
    end
  end
end
