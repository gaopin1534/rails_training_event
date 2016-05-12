class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @user.save
      login(@user)
      redirect_to root_url, :notice => "Signed in!"
    else
      render :new
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:event).permit(:title, :hold_at, :description, :capacity, :location, :owner)
    end
end
