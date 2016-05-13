require 'rails_helper'

RSpec.describe User, type: :model do
  specify "name shouldn't be empty" do
    user = User.new(
      name: '',
      nickname: 'gege',
      description: 'gge',
      uid: '1234',
      token: '1dssgsd',
      secret: 'fdsfdsfsf',
    )
    expect(user).not_to be_valid
  end

  specify "nickname shouldn't be empty" do
    user = User.new(
      name: 'hgge',
      nickname: '',
      description: 'gge',
      uid: '1234',
      token: '1dssgsd',
      secret: 'fsdfsdf',
    )
    expect(user).not_to be_valid
  end
  specify "description shouldn't be empty" do
    user = User.new(
      name: 'hgge',
      nickname: 'gege',
      description: '',
      uid: '1234',
      token: '1dssgsd',
      secret: 'fdsfdsf',
    )
    expect(user).not_to be_valid
  end

  specify "uid shouldn't be empty" do
    user = User.new(
      name: 'hgge',
      nickname: 'gege',
      description: 'gge',
      uid: '',
      token: '1dssgsd',
      secret: 'fdsfsd',
    )
    expect(user).not_to be_valid
  end

  specify "token shouldn't be empty" do
    user = User.new(
      name: 'hgge',
      nickname: 'gege',
      description: 'gge',
      uid: '1234',
      token: '',
      secret: 'fdsfsfds',
    )
    expect(user).not_to be_valid
  end

  specify "secret shouldn't be empty" do
    user = User.new(
      name: 'hgge',
      nickname: 'gege',
      description: 'gge',
      uid: '1234',
      token: '1dssgsd',
      secret: '',
    )
    expect(user).not_to be_valid
  end
end
