class User < ActiveRecord::Base
  has_many :events
  has_many :atendees
  has_many :atendeds
  has_many :atend_events, class_name: 'Event', through: :atendeds, source: :event, dependent: :delete_all
  has_many :absenteds
  has_many :absent_events, class_name: 'Event', through: :absenteds, source: :event, dependent: :delete_all
  validates :name, presence: true
  validates :nickname, presence: true
  validates :nickname, presence: true
  validates :description, presence: true

  mount_uploader :image, ImageUploader
end
