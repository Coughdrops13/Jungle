require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    describe "verify password" do
      context "of a valid user" do
        it 'is present' do
          user = User.create({ first_name: "Ron", last_name: "Swanson", email: "ron@swanson.com", password: "123abc", password_confirmation: "123abc" })
          expect(user.password).to be_present
        end
        it 'is confirmed' do
          user = User.create({ first_name: "Ron", last_name: "Swanson", email: "ron@swanson.com", password: "123abc", password_confirmation: "123abc" })
          expect(user.password_confirmation).to be_present
        end
        it 'is identical to confirmation' do
          user = User.create({ first_name: "Ron", last_name: "Swanson", email: "ron@swanson.com", password: "123abc", password_confirmation: "123abc" })
          expect(user).to be_valid
        end
      end
      context "of an invalid user" do
        it 'is not identical to confirmation' do
          user = User.create({first_name: "Ron", last_name: "Swanson", email: "ron@swanson.com", password: "123abc", password_confirmation: "abc123" })
          expect(user).not_to be_valid
        end
      end
      context 'of a invalid user' do
        it 'is long enough' do
          user = User.create({ first_name: "Ron", last_name: "Swanson", email: "ron@swanson.com", password: "123a", password_confirmation: "123a" })
          user_errors = user.errors.full_messages
          expect(user_errors).to include("Password is too short (minimum is 5 characters)")
        end
      end
    end
    describe "confirm first_name" do
      context 'for a valid user' do
        it 'is present' do
          user = User.create({first_name: "Ron", last_name: "Swanson", email: "ron@swanson.com", password: "123abc", password_confirmation: "123abc" }) 
          expect(user.first_name).to be_present
        end
        it 'allows user to be valid' do
          user = User.create({first_name: "Ron", last_name: "Swanson", email: "ron@swanson.com", password: "123abc", password_confirmation: "123abc" }) 
          expect(user).to be_valid
        end
      end
      context 'for a user without a first_name attribute' do
        it 'makes user invalid' do
          user = User.create({first_name: nil, last_name: "Swanson", email: "ron@swanson.com", password: "123abc", password_confirmation: "123abc" }) 
          expect(user).not_to be_valid
        end
      end
    end

    describe "confirm last_name" do
      context 'for a valid user' do
        it 'is present' do
          user = User.create({first_name: "Ron", last_name: "Swanson", email: "ron@swanson.com", password: "123abc", password_confirmation: "123abc" }) 
          expect(user.last_name).to be_present
        end
        it 'allows user to be valid' do
          user = User.create({first_name: "Ron", last_name: "Swanson", email: "ron@swanson.com", password: "123abc", password_confirmation: "123abc" }) 
          expect(user).to be_valid
        end
      end
      context 'for a user without a last_name attribute' do
        it 'makes user invalid' do
          user = User.create({first_name: "Ron", last_name: nil, email: "ron@swanson.com", password: "123abc", password_confirmation: "123abc" }) 
          expect(user).not_to be_valid
        end
      end
    end

    describe 'confirm email' do
      context 'for a valid user' do
        it 'is present' do
          user = User.create({first_name: "Ron", last_name: "Swanson", email: "ron@swanson.com", password: "123abc", password_confirmation: "123abc" }) 
          expect(user.email).to be_present
        end
        it 'allows user to be valid' do
          user = User.create({first_name: "Ron", last_name: "Swanson", email: "ron@swanson.com", password: "123abc", password_confirmation: "123abc" }) 
          expect(user).to be_valid
        end
      end
      context 'for an invalid user' do
        it 'makes user invalid' do
          user = User.create({first_name: "Ron", last_name: "Swanson", email: nil, password: "123abc", password_confirmation: "123abc" }) 
          expect(user).not_to be_valid
        end
      end
      context 'is unique' do
        it 'makes a user invalid' do
          user1 = User.create({first_name: "Ron", last_name: "Swanson", email: "ron@swanson.com", password: "123abc", password_confirmation: "123abc" })
          user2 = User.create({first_name: "Leslie", last_name: "Knope", email: "RON@SWANSON.com", password: "456def", password_confirmation: "456def" }) 
          user2errors = user2.errors.full_messages
          expect(user2errors).to include('Email has already been taken')
        end
      end
    end
  end
  describe '.authenticate_with_credentials' do
    context 'when email exists and passoword is correct' do
      it 'returns true' do
        user = User.create({first_name: "Ron", last_name: "Swanson", email: "ron@swanson.com", password: "123abc", password_confirmation: "123abc" })
        expect(User.authenticate_with_credentials("ron@swanson.com", "123abc")).to be_truthy
      end
    end
    context 'when email exists with whitespace and is captilized incorrectly and password is correct' do
      it 'returns true' do
        user = User.create({first_name: "Ron", last_name: "Swanson", email: "ron@swanson.com", password: "123abc", password_confirmation: "123abc" }) 
        expect(User.authenticate_with_credentials("   Ron@swanson.com", "123abc")).to be_truthy
      end
    end
    context 'when email exists and password is incorrect' do
      it 'returns false' do
        user = User.create({first_name: "Ron", last_name: "Swanson", email: "ron@swanson.com", password: "123abc", password_confirmation: "123abc" }) 
        expect(User.authenticate_with_credentials("ron@swanson.com", "1234abcd")).to be_falsey        
      end
    end
  end
end
