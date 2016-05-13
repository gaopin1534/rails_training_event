class Atendee < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  scope :atends, -> {
    where(status: "attended")
  }
  scope :absents, -> {
    where(status: "absented")
  }
  scope :with_event, ->(id) {
    where(event_id: id)
  }
  def atend?
    if self.status == "attended"
      true
    else
      false
    end
  end
end