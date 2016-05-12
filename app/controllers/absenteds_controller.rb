class AbsentedsController < ApplicationController
  before_action :login_filter
  def create
    @absent = Absented.new
    @absent.user = current_user
    @absent.event = Event.find(absented_params[:event_id])
    if @absent.save
      if @absent.event.atendees.include?(current_user)
        @atend = Atended.find_by(user: current_user)
        @atend.destroy
      end
      redirect_to @absent.event, notice: "you canceled this event!"
    else
      redirect_to @absent.event, alert: "failed canceling this event"
    end
  end

  private
    def absented_params
      params.require(:absented).permit(:event_id)
    end
end
