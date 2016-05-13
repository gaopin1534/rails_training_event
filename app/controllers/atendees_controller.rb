class AtendeesController < ApplicationController
  before_action :login_filter
  def atend
    @event = Event.find(prams[:id])
    if @atendee = Atendee.find_by(user: current_user, event: @event)
      @atendee.status = "attended"
      @atendee.save
    else
      @atendee = Atendee.new
      @atendee.event = Event.find(atended_params[:event_id])
      @atendee.user = current_user
      @atendee.save
    end
  end


  private
    def atended_params
      params.require(:atended).permit(:event_id)
    end
end
