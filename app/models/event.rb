class Event < ActiveRecord::Base
  belongs_to :owner, class_name: 'User', foreign_key: 'owner'
  has_many :atendeds
  has_many :atendees, class_name: 'User', through: :atendeds, source: :user, dependent: :delete_all
  has_many :absenteds
  has_many :absences, class_name: 'User', through: :absenteds, source: :user, dependent: :delete_all

  validates :title, presence: true
  validates :hold_at, presence: true
  validates :capacity, presence: true
  validates :location, presence: true
  validates :owner, presence: true
  validates :description, presence: true
end
