class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @events = Event.new(params[:id])
  end

  def detail
  end
end
