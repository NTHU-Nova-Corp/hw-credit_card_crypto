# frozen_string_literal: true

# Substitution Cipher - Change the letters in the plaintext
# Plaintext : Hello
module SubstitutionCipher
  # Caesar algorithm
  module Caesar
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using caesar cipher
      document.to_s.bytes.map { |c| c + key }.pack('c*')
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using caesar cipher
      document.to_s.bytes.map { |c| c - key }.pack('c*')
    end
  end

  # Permutation algorithm
  module Permutation
    # Get random tuple by shuffling
    # Arguments:
    #   key: Fixnum (integer)
    # Returns: Array
    def self.get_random_tuple(key)
      (0..127).to_a.shuffle(random: Random.new(key)).map(&:chr)
    end

    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using a permutation cipher
      document.to_s.bytes.map { |m| get_random_tuple(key)[m] }.join('')
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using a permutation cipher
      document.chars.map { |m| get_random_tuple(key).index(m) }.pack('c*')
    end
  end
end
