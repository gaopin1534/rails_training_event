class User < ActiveRecord::Base
  has_many :events, :dependent => :destroy
  has_many :atendees, :dependent => :destroy
  has_many :atend_events, -> { where "status = 'attended'"}, class_name: 'Event', through: :atendees, source: :event
  has_many :absent_events,-> { where "status = 'absented'"}, class_name: 'Event', through: :atendees, source: :event
  validates :name, presence: true
  validates :nickname, presence: true
  validates :uid, presence: true
  validates :token, presence: true
  mount_uploader :image, ImageUploader

   def get_data_from_auth_info auth
     self.name = auth.info.name
     self.uid = auth.uid
     self.nickname = auth.info.nickname
     self.description = auth.info.description
     self.token = auth.credentials.token
     self.secret = auth.credentials.secret
     uploader = ImageUploader.new
     uploader.download! auth.info.image
     self.image = uploader
   end
end
