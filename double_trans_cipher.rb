# frozen_string_literal: true

# Double Transposition Cipher - Scramble/unscramble
# letters in plaintext
module DoubleTranspositionCipher
  def self.encrypt(document, key)
    # TODO: FILL THIS IN!
    ## Suggested steps for double transposition cipher
    # 1. find number of rows/cols such that matrix is almost square
    # 2. break plaintext into evenly sized blocks
    # 3. sort rows in predictably random way using key as seed
    # 4. sort columns of each row in predictably random way
    # 5. return joined cyphertext
    plain_text = document.to_s
    _rows, cols = get_dimensions(plain_text)
    prng = get_prng(key)
    plain_text_matrix = get_matrix(plain_text, cols)

    # Shuffling columns can easily be done conceptually by
    # transposing and treating them as rows
    # Makes life easier :)
    # Rows are shuffled first, then columns

    plain_text_matrix.shuffle(random: prng).transpose
                     .shuffle(random: prng).transpose
                     .flatten.join
  end

  def self.decrypt(ciphertext, key)
    rows, cols = get_dimensions(ciphertext)
    prng = get_prng(key)
    cipher_text_matrix = get_matrix(ciphertext, cols)
    row_index, col_index = get_indices(rows, cols, prng)
    decrypt_matrix(cipher_text_matrix, row_index, col_index)
  end

  def self.decrypt_matrix(cipher_text_matrix, row_index, col_index, pad = '`')
    decrypted_text = cipher_text_matrix.sort_by.with_index { |_, i| row_index[i] }.transpose
                                       .sort_by.with_index { |_, i| col_index[i] }.transpose
                                       .flatten.join

    decrypted_text.sub(/#{pad}+\z/, '')
  end

  def self.get_dimensions(text)
    rows = Math.sqrt(text.length).floor
    cols = Math.sqrt(text.length).ceil

    rows = cols if rows * cols < text.length

    [rows, cols]
  end

  def self.get_matrix(text, cols, pad = '`')
    text.chars.chain(Array.new(-text.length % cols, pad))
        .each_slice(cols).to_a
  end

  def self.get_indices(rows, cols, prng)
    # Order matters, rows must be shuffled first
    # Related to PRNG state
    [(0...rows).to_a.shuffle(random: prng),
     (0...cols).to_a.shuffle(random: prng)]
  end

  def self.get_prng(key)
    Random.new(key.to_s.unpack1('H*').to_i(16))
  end
end
