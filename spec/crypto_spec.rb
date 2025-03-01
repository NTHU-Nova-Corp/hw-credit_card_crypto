# frozen_string_literal: true

require_relative '../credit_card'
require_relative '../substitution_cipher'
require_relative '../double_trans_cipher'
require_relative '../sk_cipher'
require 'minitest/autorun'

describe 'Test card info encryption' do
  before do
    @text_with_space = '    Hello, how are you?   '
    @cc = CreditCard.new('4916603231464963', 'Mar-30-2020',
                         'Soumya Ray', 'Visa')
    @key = 3
  end

  describe 'Using caesar cipher' do
    it 'should encrypt card information' do
      enc = SubstitutionCipher::Caesar.encrypt(@cc, @key)
      _(enc).wont_equal @cc.to_s
      _(enc).wont_be_nil
    end

    it 'should decrypt text' do
      enc = SubstitutionCipher::Caesar.encrypt(@cc, @key)
      dec = SubstitutionCipher::Caesar.decrypt(enc, @key)
      _(dec).must_equal @cc.to_s
    end

    it 'should decrypt text with spaces correctly' do
      enc = SubstitutionCipher::Caesar.encrypt(@text_with_space, @key)
      dec = SubstitutionCipher::Caesar.decrypt(enc, @key)
      _(dec).must_equal @text_with_space
    end
  end

  describe 'Using permutation cipher' do
    it 'should encrypt card information' do
      enc = SubstitutionCipher::Permutation.encrypt(@cc, @key)
      _(enc).wont_equal @cc.to_s
      _(enc).wont_be_nil
    end

    it 'should decrypt text' do
      enc = SubstitutionCipher::Permutation.encrypt(@cc, @key)
      dec = SubstitutionCipher::Permutation.decrypt(enc, @key)
      _(dec).must_equal @cc.to_s
    end

    it 'should decrypt text with spaces correctly' do
      enc = SubstitutionCipher::Permutation.encrypt(@text_with_space, @key)
      dec = SubstitutionCipher::Permutation.decrypt(enc, @key)
      _(dec).must_equal @text_with_space.to_s
    end
  end

  # TODO: Add tests for double transposition and modern symmetric key ciphers
  #       Can you DRY out the tests using metaprogramming? (see lecture slide)
  describe 'Using double transposition cipher' do
    it 'should encrypt card information' do
      enc = DoubleTranspositionCipher.encrypt(@cc, @key)
      _(enc).wont_equal @cc.to_s
      _(enc).wont_be_nil
    end

    it 'should decrypt text' do
      enc = DoubleTranspositionCipher.encrypt(@cc, @key)
      dec = DoubleTranspositionCipher.decrypt(enc, @key)
      _(dec).must_equal @cc.to_s
    end

    it 'should decrypt text with spaces correctly' do
      enc = DoubleTranspositionCipher.encrypt(@text_with_space, @key)
      dec = DoubleTranspositionCipher.decrypt(enc, @key)
      _(dec).must_equal @text_with_space
    end

    it 'should decrypt text ends with hyphen correctly' do
      text_with_hyphen = 'my message --'
      enc = DoubleTranspositionCipher.encrypt(text_with_hyphen, @key)
      dec = DoubleTranspositionCipher.decrypt(enc, @key)
      _(dec).must_equal text_with_hyphen
    end
  end

  describe 'Using modern symmetric cipher' do
    it 'should encrypt card information' do
      key = ModernSymmetricCipher.generate_new_key
      enc = ModernSymmetricCipher.encrypt(@cc, key)
      _(enc).wont_equal @cc.to_s
      _(enc).wont_be_nil
    end

    it 'should decrypt text' do
      key = ModernSymmetricCipher.generate_new_key
      enc = ModernSymmetricCipher.encrypt(@cc, key)
      dec = ModernSymmetricCipher.decrypt(enc, key)
      _(dec).must_equal @cc.to_s
    end

    it 'should decrypt text with spaces correctly' do
      key = ModernSymmetricCipher.generate_new_key
      enc = ModernSymmetricCipher.encrypt(@text_with_space, key)
      dec = ModernSymmetricCipher.decrypt(enc, key)
      _(dec).must_equal @text_with_space
    end
  end
end
