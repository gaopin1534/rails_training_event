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
    @event.owner = current_user.name
    @event.user = current_user
    if @event.save
      redirect_to @event, :notice => "event created!"
    else
      render :new
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path, notice: "event was deleted!"
  end

  def update
    @event = Event.find(params[:id])
    @event.owner = current_user.name
    if @event.update_attributes(event_params)
      redirect_to @event, notice: "event updated"
    else
      render 'edit'
    end
  end

  def absent
    @event = Event.find(params[:id])
    @atendee = Atendee.find_by(user: current_user, event: @event)
    @atendee.status = "absented"
    @atendee.save
    redirect_to @event
  end

  def atend
    @event = Event.find(params[:id])
    if @atendee = Atendee.find_by(user: current_user, event: @event)
      @atendee.status = "attended"
      @atendee.save
    else
      @atendee = Atendee.new
      @atendee.event = Event.find(params[:id])
      @atendee.user = current_user
      @atendee.status = "attended"
      @atendee.save
    end

    redirect_to @event , notice: current_user.name + ' " in "'
  end
  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :hold_at, :description, :capacity, :location)
    end
end
