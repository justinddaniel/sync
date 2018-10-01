class EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
    @users = User.all
  end

  def create
    @event = Event.create(event_params)
    @event.host = current_user.host
    @users = User.all
    redirect_to events_path

  end

  def edit
    @user = current_user
    @users = User.all
    @event = Event.find_by(id: params[:id])
    # @events = @user.host.events

    # @user = Event.find_by(id: params[:host_id])
    # @event = @user.events.build(user_id: current_user.id)
    # show if checkboxes are checked
    # if params[:check].eql?('1')
  end

  def update
    @event = Event.find_by(id: params[:id])
    @event.update(event_params)
    if current_user.id == @event.host.user.id
      redirect_to event_path(@event)
    else
      redirect_to root_path, flash: {danger: "Please login to edit your event."}
    end
  end

  def destroy
    @event.delete
    redirect_to event_path(@event), flash: {success: "'#{@event.title}' was deleted!"}
  end

  private
  def event_params
    params.require(:event).permit(
        :name,
        :location,
        :date_from
      )
end


end
