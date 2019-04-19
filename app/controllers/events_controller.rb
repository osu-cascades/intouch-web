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

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.update(event_params)

    redirect_to event_path(@event)
   end


  def create
  	event = Event.create(event_params)

  	redirect_to events_path
  end

 	def destroy
    @event = Event.find(params[:id])
    @event.destroy

    redirect_to events_path
  end

  private

  def event_params
  	params.require(:event).permit(:title, :description, :time, :place, :notes, :group_participants, :hosted_by)
  end
end
