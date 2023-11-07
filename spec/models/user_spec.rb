require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  describe 'Validations' do
    it 'should be valid with valid attributes' do
      # Use user (local variable) when the variable is specific to a single example and doesn't need to be shared.
      user = User.new(
        name: 'John Doe',
        email: 'john@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).to be_valid
    end

    it 'should not be valid if password and password_confirmation do not match' do
      user = User.new(
        name: 'John Doe',
        email: 'john@example.com',
        password: 'password',
        password_confirmation: 'different_password'
      )
      expect(user).not_to be_valid
    end

    it 'should not be valid without a password' do
      user = User.new(
        name: 'John Doe',
        email: 'john@example.com'
      )
      expect(user).not_to be_valid
    end

    it 'should not be valid if email is not unique (case insensitive)' do
      User.create(
        name: 'John Doe',
        email: 'john@example.com',
        password: 'password',
        password_confirmation: 'password'
      )

      user = User.new(
        name: 'John Doe',
        email: 'JOHN@example.com',
        password: 'different_password',
        password_confirmation: 'different_password'
      )
      expect(user).not_to be_valid
    end

    it 'should not be valid without a name' do
      user = User.new(
        email: 'john@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).not_to be_valid
    end

    it 'should not be valid without an email' do
      user = User.new(
        name: 'John Doe',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).not_to be_valid
    end

    it 'should be invalid if password is too short' do
      user = User.new(
        name: 'John Doe',
        email: 'john@example.com',
        password: 'short',
        password_confirmation: 'short'
      )
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
  end

  # .authenticate_with_credentials is the class method while #authenticate_with_credentials is instance method in rspec test
  describe '.authenticate_with_credentials' do
    it 'should authenticate with valid credentials' do
      user = User.create(
        name: 'John Doe',
        email: 'john@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
      authenticated_user = User.authenticate_with_credentials('john@example.com', 'password123')
      expect(authenticated_user).to eq(user)
    end

    it 'should not authenticate with invalid email' do
      user = User.create(
        name: 'John Doe',
        email: 'john@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
      authenticated_user = User.authenticate_with_credentials('invalid@example.com', 'password123')
      expect(authenticated_user).to be_nil
    end

    it 'should not authenticate with invalid password' do
      user = User.create(
        name: 'John Doe',
        email: 'john@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
      authenticated_user = User.authenticate_with_credentials('john@example.com', 'invalid_password')
      expect(authenticated_user).to be_nil
    end

    it 'should authenticate with spaces around email' do
      user = User.create(
        name: 'John Doe',
        email: 'john@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
      authenticated_user = User.authenticate_with_credentials('  john@example.com  ', 'password123')
      expect(authenticated_user).to eq(user)
    end

    it 'should authenticate with case-insensitive email' do
      user = User.create(
        name: 'John Doe',
        email: 'john@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
      authenticated_user = User.authenticate_with_credentials('JOHN@EXAMPLE.COM', 'password123')
      expect(authenticated_user).to eq(user)
    end
  end
end
