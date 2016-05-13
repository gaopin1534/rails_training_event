class User < ActiveRecord::Base
  has_many :events
  has_many :atendees

  validates :name, presence: true
  validates :nickname, presence: true
  validates :nickname, presence: true
  validates :description, presence: true

  mount_uploader :image, ImageUploader
end
