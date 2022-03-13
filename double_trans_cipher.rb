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
    _rows, cols = get_dims(document)
    prng = get_prng(key)
    ptext_matrix = get_matrix(document, cols)

    # Shuffling columns can easily be done conceptually by
    # transposing and treating them as rows
    # Makes life easier :)
    # Rows are shuffled first, then columns

    ptext_matrix.shuffle(random: prng).transpose
                .shuffle(random: prng).transpose
                .flatten.join
  end

  def self.decrypt(ciphertext, key)
    # TODO: FILL THIS IN!
    rows, cols = get_dims(ciphertext)
    prng = get_prng(key)
    ctext_matrix = get_matrix(ciphertext, cols)

    r_idx, c_idx = get_indices(rows, cols, prng)

    ctext_matrix.sort_by.with_index { |_, i| r_idx[i] }.transpose
                .sort_by.with_index { |_, i| c_idx[i] }.transpose
                .flatten.join
  end

  def self.get_dims(string)
    rows = Math.sqrt(string.length).floor
    cols = Math.sqrt(string.length).ceil
    rows = cols if rows * cols < string.length

    [rows, cols]
  end

  def self.get_matrix(string, cols, pad = ' ')
    string.chars.chain(Array.new(-string.length % cols, pad))
          .each_slice(cols).to_a
  end

  def self.get_indices(rows, cols, prng)
    # Order matters, rows must be shuffled first
    # Related to PRNG state
    [(0...rows).to_a.shuffle(random: prng),
     (0...cols).to_a.shuffle(random: prng)]
  end

  def self.get_prng(key)
    Random.new(key.unpack1('H*').to_i(16))
  end
end
