class Event < ActiveRecord::Base
  belongs_to :user
  has_many :atendees, :dependent => :destroy
  has_many :atends, class_name: 'User', through: :atendees, source: :user

  validates :title, presence: true
  # validates :hold_at, presence: true
  validates :capacity, presence: true, numericality: { greater_than_or_equal_to: 1 } 
  validates :location, presence: true
  validates :owner, presence: true
  validates :description, presence: true
  validates :user, presence: true

  scope :atends, -> {
    where(status: "attended")
  }
  scope :absents, -> {
    where(status: "absented")
  }
end
