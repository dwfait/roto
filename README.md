# Roto

## What is Roto?
Roto is an extraction of the token generation / encryption mechanism used in a microservices architecture experiment I wrote.

It's very similar to EWT (Encrypted Web Tokens, a counterpart to JWT), in that it transforms JSON into an encrypted token with a HMAC (hashed message authentication code).

## Should I use Roto?
tl;dr: No.

It has been written by someone as an experiment; someone who is not a security expert. I will be improving it over time potentially, but you should probably just use EWT.

## What's the purpose?
Roto is designed to be very easy to use. You plug in your JSON, give it a couple of encryption keys to use, and you'll get a foolproof, safely encrypted and authenticated token using all the current industry best-practices.

This token can then be stored on a client device, and sent up to any service which has the same keys, which can then decrypt and use the JSON. The token can contain any sensitive data, such as user ID, authorisation roles (e.g. `admin: true`), and it is guaranteed to be a secret.

Not that being secret protects you - there is no security in obscurity. What protects you is the HMAC which is included in each encrypted token - this ensures that the message has not been tampered or altered in any way between the generation / encryption, and the decryption.

What it does *not* protect you against, is someone from stealing the encrypted token, and then sending that token up with a request, pretending to be you. Therefore, you should always make sure that the locations in which you _store_ the tokens, and the channels in which you transmit the token, are also secure (which means SSL / TLS), otherwise you are open to attack.

## The inner workings
At the moment, Roto uses the OpenSSL implementation of AES 128 CBC (never use EBC).

It generates a random IV (initialization vector) for each token.

For the HMAC, it currently uses SHA1, but there are plans to move this to SHA256.

# How to use
## Encrypting
```Ruby
json = { user_id: 123, admin: false }.as_json
encryptor = Roto::Encryptor.new(cipher_key, hmac_key)
encrypted = encryptor.encrypt(json)
```

## Decrypting
```Ruby
decryptor = Roto::Decryptor.new(cipher_key, hmac_key)
plain = decryptor.decrypt(encrypted)
```

If in the decryption process tampering has been detected (if the HMAC is incorrect), then a `Roto::Errors::InvalidHMACError` is thrown.

# Contributing
Contributions are most welcome. Even if you just open an issue, I'll be happy to take a look when I get the time to. If you want to contribute, then use the standard github fork and pull-request method.
