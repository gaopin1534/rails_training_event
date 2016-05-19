class User < ActiveRecord::Base
  has_many :events, :dependent => :destroy
  has_many :atendees, :dependent => :destroy
  has_many :atend_events, -> { where "status = 'attended'"}, class_name: 'Event', through: :atendees, source: :event
  has_many :absent_events,-> { where "status = 'absented'"}, class_name: 'Event', through: :atendees, source: :event
  has_many :waiting_events,-> { where "status = 'waiting'"}, class_name: 'Event', through: :atendees, source: :event
  validates :name, presence: true
  validates :nickname, presence: true
  validates :uid, presence: true
  validates :token, presence: true
  mount_uploader :image, ImageUploader


  def get_data_from_auth_info auth
    self.name = auth.info.name
    self.uid = auth.uid
    self.token = auth.credentials.token
    self.secret = auth.credentials.secret
    self.provider = auth.provider
    uploader = ImageUploader.new
    self.description = auth.info.description
    if(auth.provider == "facebook")
      self.nickname = auth.info.email
      uploader.download!  "https://graph.facebook.com/#{auth.uid}/picture?type=square"
    else
      self.nickname = auth.info.nickname
      uploader.download!(auth.info.image)
    end
    self.image = uploader
  end

  def get_data_from_auth_info_for_update auth
    self.name = auth.info.name
    self.uid = auth.uid
    self.description = auth.info.about
    if(auth.provider == "facebook")
      self.nickname = auth.info.email
    else
      self.nickname = auth.info.nickname
    end
    self.token = auth.credentials.token
    self.secret = auth.credentials.secret
    self.provider = auth.provider
  end
end
