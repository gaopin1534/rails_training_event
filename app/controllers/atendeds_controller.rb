class AtendedsController < ApplicationController
  before_action :login_filter
  def create
    @atend = Atended.new
    @atend.user = current_user
    @atend.event = Event.find(atended_params[:event_id])
    if @atend.save
      if @atend.event.absences.include?(current_user)
        @absent = Absented.find_by(user: current_user)
        @absent.destroy
      end
      redirect_to @atend.event, notice: "you joined this event!"
    else
      redirect_to @atend.event, alert: "failed joining this event"
    end
  end

  private
    def atended_params
      params.require(:atended).permit(:event_id)
    end
end
