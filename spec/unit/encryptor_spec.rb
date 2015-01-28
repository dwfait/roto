require 'spec_helper'

describe Roto::Encryptor do
  subject { Roto::Encryptor.new(test_cipher_key, test_hmac_key) }

  describe 'size of encrypted text returns' do
    ['small', 'large large large large large large', 'x'*255].each do |plain|
      it 'should be correct size' do
        hmac_bytes = 20
        aes_block_size = 16
        iv_bytes = aes_block_size
        plain_text_bytes = plain.bytes.count
        expected_cipher_text_bytes =
          (plain_text_bytes / aes_block_size.to_f).ceil * aes_block_size
        expected_size = hmac_bytes + iv_bytes + expected_cipher_text_bytes

        expect(subject.encrypt(plain).bytes.count).to eq(expected_size)
      end
    end
  end
end
