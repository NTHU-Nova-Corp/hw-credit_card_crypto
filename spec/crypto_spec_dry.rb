# frozen_string_literal: true

require_relative '../credit_card'
require_relative '../substitution_cipher'
require_relative '../double_trans_cipher'
require_relative '../sk_cipher'
require 'minitest/autorun'

ciphers = { 'caesar' => 'SubstitutionCipher::Caesar',
            'permutation' => 'SubstitutionCipher::Permutation',
            'double transposition' => 'DoubleTranspositionCipher',
            'modern symmetric' => 'ModernSymmetricCipher' }

ciphers.each do |type, module_name|
  describe 'Test card info encryption' do
    before do
      @cc = CreditCard.new('4916603231464963', 'Mar-30-2020', 'Soumya Ray', 'Visa')
      @text_with_spaces = '    Hello, how are you?   '
      @text_with_hyphen = 'my message --'
      @key = if type == 'modern symmetric'
               ModernSymmetricCipher.generate_new_key
             else
               3
             end
    end

    describe "Using #{type} cipher" do
      it 'should encrypt card information' do
        enc = Kernel.const_get(module_name).encrypt(@cc, @key)
        _(enc).wont_equal @cc.to_s
        _(enc).wont_be_nil
      end

      it 'should decrypt text' do
        enc = Kernel.const_get(module_name).encrypt(@cc, @key)
        dec = Kernel.const_get(module_name).decrypt(enc, @key)
        _(dec).must_equal @cc.to_s
      end

      it 'should decrypt text with spaces correctly' do
        enc = Kernel.const_get(module_name).encrypt(@text_with_spaces, @key)
        dec = Kernel.const_get(module_name).decrypt(enc, @key)
        _(dec).must_equal @text_with_spaces
      end

      it 'should decrypt text with text ends with hyphen correctly' do
        enc = Kernel.const_get(module_name).encrypt(@text_with_hyphen, @key)
        dec = Kernel.const_get(module_name).decrypt(enc, @key)
        _(dec).must_equal @text_with_hyphen
      end
    end
  end
end
