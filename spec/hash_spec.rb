# frozen_string_literal: true

require_relative '../credit_card'
require 'minitest/autorun'
require 'yaml'

card_details = YAML.load_file 'spec/test_data/test_credit_card_info.yml'
cards = card_details['card_details'].map do |c|
  CreditCard.new(c['num'], c['exp'], c['name'], c['net'])
end
duplicated_cards = cards.dup

describe 'Test hashing requirements' do
  describe 'Test regular hashing' do
    describe 'Check hashes are consistently produced' do
      cards.each_with_index do |e, i|
        it "should have identical hashes at index #{i}" do
          _(e.hash).must_equal duplicated_cards[i].hash
        end
      end
    end

    describe 'Check for unique hashes' do
      # TODO: Check that each card produces a different hash than other cards
      it 'should not produce identical hash for different cards' do
        unique_hashes = cards.map(&:hash).uniq
        _(cards.length).must_equal unique_hashes.length
      end
    end
  end

  describe 'Test cryptographic hashing' do
    describe 'Check hashes are consistently produced' do
      # TODO: Check that each card produces the same hash if hashed repeatedly
      cards.each_with_index do |e, i|
        it "should have identically cryptographic hashes at index #{i}" do
          _(e.hash_secure).must_equal duplicated_cards[i].hash_secure
        end
      end
    end

    describe 'Check for unique hashes' do
      # TODO: Check that each card produces a different hash than other cards
      it 'should not produce identical hash for different cards' do
        unique_hashes = cards.map(&:hash_secure).uniq
        _(cards.length).must_equal unique_hashes.length
      end
    end

    describe 'Check regular hash not same as cryptographic hash' do
      # TODO: Check that each card's hash is different from its hash_secure
      cards.each_with_index do |e, i|
        it "should have differently cryptographic hashes at index #{i}" do
          _(e.hash).wont_equal e.hash_secure
        end
      end
    end
  end
end
