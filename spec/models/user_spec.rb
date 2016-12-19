require 'rails_helper'

RSpec.describe User do
  it 'requires a first name' do
    john = User.new(first_name: nil, last_name: 'Doe',
    email: 'john@example.com', password: 'password')
    expect(john).not_to be_valid
    expect(john.errors[:first_name].any?).to be_truthy
  end
  it 'requires a last name' do
    john = User.new(first_name: 'John', last_name: nil,
    email: 'john@example.com', password: 'password')
    expect(john).not_to be_valid
    expect(john.errors[:last_name].any?).to be_truthy
  end
  it 'requires an email address' do
    john = User.new(first_name: 'John', last_name: 'Doe',
    email: nil, password: 'password')
    expect(john).not_to be_valid
    expect(john.errors[:email].any?).to be_truthy
  end
  it 'requires a password' do
    john = User.new(first_name: 'John', last_name: 'Doe',
    email: 'john@example.com', password: nil)
    expect(john).not_to be_valid
    expect(john.errors[:password].any?).to be_truthy
  end

  it "is not an admin by default" do
    john = Fabricate.create(:user)
    expect(john.admin?).to be_falsey
  end

  context "when user is an admin" do
    it "should be a valid admin" do
      john = Fabricate.create(:admin)
      expect(john.admin?).to be_truthy
    end
  end

  describe '#full_name' do
    it 'requires a full name' do
      john = User.create(first_name: 'John', last_name: 'Doe',
      email: 'john@example.com', password: 'password')
      expect(john.full_name).to eq('John Doe')
    end
  end


end
