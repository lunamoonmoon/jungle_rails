require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    before(:each) do
      @user = User.new(
        name: 'puppycat',
        email: 'puppycat@gmail.com',
        password: 'puppycat123',
        password_confirmation: 'puppycat123'
      )
    end

    it "has a matching password and password confirmation" do
      @user.password = "123password"
      @user.password_confirmation = "123p"
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "has an email" do
      # violate the validation rule
      @user.email = nil
      # attempt to save
      @user.save
      # check error message is correct
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "has a unique email" do
      User.create!(name: 'elmo', email: 'test@example.com', password: '123password', password_confirmation: '123password')
      # violate the validation rule
      @user.email = 'test@example.com'
      # attempt to save
      @user.save
      # check error message is correct
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "has a name" do
      @user.name = nil
      @user.save
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end

    it "has a password with a minimum length" do
      @user.password = "123p"
      @user.password_confirmation = "123p"
      @user.save
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    before(:each) do
      @user = User.new(
          name: 'Bill Quack',
          email: 'quack@qmail.com',
          password: 'notaduck',
          password_confirmation: 'notaduck'
        )
        @user.save
      end

    it 'authenticates with valid credidetials' do
      expect(User.authenticate_with_credentials('quack@qmail.com', 'notaduck')).to eq(@user)
    end
  end

end
