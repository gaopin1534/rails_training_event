class User < ActiveRecord::Base
  has_many :events, :dependent => :destroy
  has_many :atendees, :dependent => :destroy
  has_many :atend_events, class_name: 'Event', through: :atendees, source: :event
  validates :name, presence: true
  validates :nickname, presence: true
  validates :description, presence: true
  validates :uid, presence: true
  validates :token, presence: true
  validates :secret, presence: true
  mount_uploader :image, ImageUploader
end
