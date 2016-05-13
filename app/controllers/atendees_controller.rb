class AtendeesController < ApplicationController
  before_action :login_filter


  private
    def atended_params
      params.require(:atended).permit(:event_id)
    end
end
