class User < ActiveRecord::Base
  has_many :events, foreign_key: "owner"
  has_many :atendeds
  has_many :atend_events, class_name: 'Event', through: :atended, dependent: :delete_all
  has_many :absenteds
  has_many :absent_events, class_name: 'Event', through: :absented, dependent: :delete_all
  validates :name, presence: true
  validates :nickname, presence: true
  validates :nickname, presence: true
  validates :discription, presence: true

  mount_uploader :image, ImageUploader
end
