require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:user){ create :user }
  specify "title shouldn't be empty elements" do
    event = Event.new(
      title: '',
      hold_at: '2016-11-14 12:00:00',
      capacity: '12',
      location: 'gegege',
      owner: 'hoge',
      description: 'dfdfsfdsafa',
      user: User.new
    )
    expect(event).not_to be_valid
  end

  # specify "hold_at shouldn't be empty elements" do
  #   event = Event.new(
  #     title: 'hogege',
  #     hold_at: '',
  #     capacity: '12',
  #     location: 'gegege',
  #     owner: 'hoge',
  #     description: 'dfdfsfdsafa',
  #     user: User.new
  #   )
  #   expect(event).not_to be_valid
  # end
  specify "capacity shouldn't be empty elements" do
    event = Event.new(
      title: 'hogege',
      hold_at: '2016-11-14 12:00:00',
      capacity: '',
      location: 'gegege',
      owner: 'hoge',
      description: 'dfdfsfdsafa',
      user: User.new
    )
    expect(event).not_to be_valid
  end
  specify "location shouldn't be empty elements" do
    event = Event.new(
      title: 'hogege',
      hold_at: '2016-11-14 12:00:00',
      capacity: '12',
      location: '',
      owner: 'hoge',
      description: 'dfdfsfdsafa',
      user: User.new
    )
    expect(event).not_to be_valid
  end
  specify "owner shouldn't be empty elements" do
    event = Event.new(
      title: 'hogege',
      hold_at: '2016-11-14 12:00:00',
      capacity: '12',
      location: 'gegege',
      owner: '',
      description: 'dfdfsfdsafa',
      user: User.new
    )
    expect(event).not_to be_valid
  end
  specify "description shouldn't be empty elements" do
    event = Event.new(
      title: 'hogege',
      hold_at: '2016-11-14 12:00:00',
      capacity: '12',
      location: 'gegege',
      owner: 'hoge',
      description: '',
      user: User.new
    )
    expect(event).not_to be_valid
  end

  let(:event){ create :event }
end
