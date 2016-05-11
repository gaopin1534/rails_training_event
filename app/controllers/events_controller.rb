class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def detail
  end
end
