class User < ActiveRecord::Base
  has_many :events
  has_many :atendees

  validates :name, presence: true
  validates :nickname, presence: true
  validates :description, presence: true
  validates :uid, presence: true
  validates :token, presence: true
  validates :secret, presence: true
  mount_uploader :image, ImageUploader
end
