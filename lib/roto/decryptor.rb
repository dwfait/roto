module Roto
  class Decryptor
    def initialize(cipher_key, hmac_key)
      @cipher_key = cipher_key
      @hmac_key = hmac_key
    end

    def decrypt(encrypted)
      hmac = encrypted[0,20]
      iv = encrypted[20,16]
      cipher_text = encrypted[36, encrypted.length]
      iv_and_cipher = encrypted[20, encrypted.length]

      validate_hmac(hmac, iv_and_cipher)
      get_plain(iv, cipher_text)
    end

    private
    attr_accessor :cipher_key, :hmac_key

    def validate_hmac(hmac, cipher_text)
      digest = OpenSSL::Digest.new('sha1')
      new_hmac = OpenSSL::HMAC.digest(digest, hmac_key, cipher_text)
      unless hmac.bytes == new_hmac.bytes
        raise Roto::Errors::InvalidHMACError.new
      end
    end

    def get_plain(iv, cipher_text)
      cipher = OpenSSL::Cipher::AES.new(128, :CBC)
      cipher.decrypt
      cipher.key = cipher_key
      cipher.iv = iv

      cipher.update(cipher_text) + cipher.final
    end
  end
end
