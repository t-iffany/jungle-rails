require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'Validations' do
    # validation tests/examples here

    it "creates and saves a user successfully if password and password_confirmation fields are set" do
      @user = User.new(
        first_name: 'firstName', 
        last_name: 'lastName', 
        email: 'test@gmail.com', 
        password: 'testPass', 
        password_confirmation: 'testPass')

      expect(@user).to be_valid
      expect(@user.errors.full_messages).to_not include('Password can\'t be blank')
      expect(@user.errors.full_messages).to_not include('Password confirmation can\'t be blank')
    end

    it "throws an error if password and password_confirmation do not match" do
      @user = User.new(
        first_name: 'firstName', 
        last_name: 'lastName', 
        email: 'test@gmail.com', 
        password: 'testPass', 
        password_confirmation: 'diffPass')

      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include('Password confirmation doesn\'t match Password')
    end

    it "does not create a user if email already exists (not case sensitive)" do
      @user1 = User.new(
        first_name: 'firstName', 
        last_name: 'lastName', 
        email: 'test@test.COM', 
        password: 'testPass', 
        password_confirmation: 'testPass')
      
      @user1.save

      @user2 = User.new(
        first_name: 'firstName2', 
        last_name: 'lastName2', 
        email: 'TEST@TEST.com', 
        password: 'testPass2', 
        password_confirmation: 'testPass2')

      expect(@user2).to_not be_valid
    end

    it "does not create a user if email is blank" do
      @user = User.new(
        first_name: 'firstName', 
        last_name: 'lastName', 
        email: nil, 
        password: 'pass', 
        password_confirmation: 'pass')

      expect(@user).to_not be_valid
    end

    it "does not create a user if first_name is blank" do
      @user = User.new(
        first_name: nil, 
        last_name: 'lastName', 
        email: 'test@gmail.com', 
        password: 'pass', 
        password_confirmation: 'pass')

      expect(@user).to_not be_valid
    end

    it "does not create a user if last_name is blank" do
      @user = User.new(
        first_name: 'firstName', 
        last_name: nil, 
        email: 'test@gmail.com', 
        password: 'pass', 
        password_confirmation: 'pass')

      expect(@user).to_not be_valid
    end

    it "does not create a user if password is less than 3 characters" do
      @user = User.new(
        first_name: 'firstName', 
        last_name: 'lastName', 
        email: 'test@gmail.com', 
        password: 'i', 
        password_confirmation: 'i')

      expect(@user).to_not be_valid
    end

  end

  describe '.authenticate_with_credentials' do
    # examples for this class method here

    it "should return user if correct email and password" do
      @user = User.new(
        first_name: 'firstName',
        last_name: 'lastName',
        email: 'test@test.COM',
        password: 'testPass',
        password_confirmation: 'testPass'
      )
      
      @user.save

      expect(User.authenticate_with_credentials('test@test.COM', 'testPass')).to_not be nil
    end

    it "should not authenticate if incorrect email" do
      @user = User.new(
        first_name: 'firstName',
        last_name: 'lastName',
        email: 'test@test.COM',
        password: 'testPass',
        password_confirmation: 'testPass'
      )
      
      @user.save

      expect(User.authenticate_with_credentials('wrong@email.com', 'testPass')).to be nil
    end

    it "should not authenticate if incorrect password" do
      @user = User.new(
        first_name: 'firstName',
        last_name: 'lastName',
        email: 'test@test.COM',
        password: 'testPass',
        password_confirmation: 'testPass'
      )
      
      @user.save

      expect(User.authenticate_with_credentials('test@test.COM', 'wrongPass')).to_not eq(@user)
    end

    it "should authenticate even if there are whitespace before/after email" do
      @user = User.new(
        first_name: 'firstName',
        last_name: 'lastName',
        email: 'test@test.COM',
        password: 'testPass',
        password_confirmation: 'testPass'
      )
      
      @user.save

      expect(User.authenticate_with_credentials('   test@test.COM   ', 'testPass')).to_not be nil
    end

    it "should authenticate even if there are wrong cases for email" do
      @user = User.new(
        first_name: 'firstName',
        last_name: 'lastName',
        email: 'test@test.COM',
        password: 'testPass',
        password_confirmation: 'testPass'
      )
      
      @user.save

      expect(User.authenticate_with_credentials('tESt@TesT.com', 'testPass')).to_not be nil
    end

  end

end
