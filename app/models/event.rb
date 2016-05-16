class Event < ActiveRecord::Base
  belongs_to :user
  has_many :atendees, :dependent => :destroy
  has_many :atends, class_name: 'User', through: :atendees, source: :user

  validates :title, presence: true
  # validates :hold_at, presence: true
  validates :capacity, presence: true
  validates :location, presence: true
  validates :owner, presence: true
  validates :description, presence: true
  validates :user, presence: true
end
