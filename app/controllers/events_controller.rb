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

  def tweet
    text = params[:tweet]
    twitter_client.update(text)
    flash[:notice] = t :tweet_notice
    redirect_to events_path
  end

  def absent
    @event = Event.find(params[:id])
    @atendee = Atendee.find_by(user: current_user, event: @event)
    @atendee.status = "absented"
    @atendee.save
    redirect_to @event, notice: '参加をキャンセルしました'
  end

  def atend
    @event = Event.find(params[:id])
    if @atendee = Atendee.find_by(user: current_user, event: @event)
      @atendee.status = "attended"
      @atendee.save
    else
      @atendee = Atendee.new
      @atendee.atend_params Event.find(params[:id]), current_user, 'attended'
      @atendee.save
    end

    redirect_to @event , notice: 'イベントに参加しました'
  end
  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :hold_at, :description, :capacity, :location)
    end

    def twitter_client
      Twitter::REST::Client.new do |config|
        # applicationの設定
        config.consumer_key         = Settings.twitter_key
        config.consumer_secret      = Settings.twitter_secret
        # ユーザー情報の設定
        config.access_token         = current_user.token
        config.access_token_secret  = current_user.secret
      end
    end
end
