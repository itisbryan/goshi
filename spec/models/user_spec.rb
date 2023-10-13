require 'rails_helper'

RSpec.describe User do
  describe '#save' do
    it 'is valid with valid attributes' do
      user = build(:user)
      expect(user.valid?).to be(true)
    end

    it 'is not valid without an email' do
      user = described_class.new(email: '')
      expect(user.valid?).to be(false)
    end

    it 'is not valid without a first name' do
      user = described_class.new(first_name: '')
      expect(user.valid?).to be(false)
    end

    it 'is not valid without a last name' do
      user = described_class.new(last_name: '')
      expect(user.valid?).to be(false)
    end

    it 'is not valid without a login' do
      user = described_class.new(login: '')
      expect(user.valid?).to be(false)
    end

    it 'is not valid without an encrypted password' do
      user = described_class.new(password: '')
      expect(user.valid?).to be(false)
    end

    it 'validates uniqueness of email' do
      described_class.build(email: 'user@example.com')
      user2 = described_class.build(email: 'user@example.com')
      expect(user2.valid?).to be(false)
    end

    it 'has created_at and updated_at timestamps' do
      user = described_class.new
      expect(user.respond_to?(:created_at)).to be(true)
      expect(user.respond_to?(:updated_at)).to be(true)
    end
  end
end
