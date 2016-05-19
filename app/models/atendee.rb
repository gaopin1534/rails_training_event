class Atendee < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  scope :atends, -> {
    where(status: "attended")
  }
  scope :absents, -> {
    where(status: "absented")
  }

  scope :waits, -> {
    where(status: "waiting")
    .order("created_at ASC")
  }
  scope :waits_and_atends, -> {
    where("status = 'waiting' OR status = 'attended'")
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

  def wait?
    if self.status == "waiting"
      true
    else
      false
    end
  end

  def atend_btn event
    if self.atend?
       "Absent"
    elsif event.atendees.atends.count == event.capacity
      if self.wait?
        "Cancel Waiting"
      else
        "Join Wait List"
      end
    else
      "Atend"
    end
  end

  def atend_params event, user, status
    self.event = event
    self.user = user
    self.status = status
  end

end
