module Roto
  class Encryptor
    def initialize(cipher_key, hmac_key)
      @cipher_key = cipher_key
      @hmac_key = hmac_key
    end

    def encrypt(plain)
      plain = plain.to_s
      encrypted = cipher_text(plain)
      "#{hmac(encrypted)}#{encrypted}"
    end

    private

    attr_accessor :cipher_key, :hmac_key

    def hmac(encrypted)
      digest = OpenSSL::Digest.new('sha1')
      OpenSSL::HMAC.digest(digest, hmac_key, encrypted)
    end

    def cipher_text(plain)
      cipher = OpenSSL::Cipher::AES.new(128, :CBC)
      cipher.encrypt
      cipher.key = cipher_key
      iv = cipher.random_iv

      "#{iv}#{cipher.update(plain) + cipher.final}"
    end
  end
end
