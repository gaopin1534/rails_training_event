class EventsController < ApplicationController
  before_action :login_filter, except: [:index,:show]
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.new(event_params)
    @event.owner = current_user
    if @event.save
      redirect_to @event, :notice => "event created!"
    else
      render :new
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      redirect_to @event, notice: "event updated"
    else
      render 'edit'
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :hold_at, :description, :capacity, :location)
    end
end
