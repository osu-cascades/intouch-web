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
    @event = Event.new(event_params)
    @groups = Group.where(id: params[:event][:group_participants])
    @event.group_participants = nil
    @groups.each do |group|
      @event.groups << group
      @event.group_participants << group.name
    end

    if @event.save
      flash[:success] = 'Event created!'
      redirect_to events_path
    else
      render 'new'
    end
  end

 	def destroy
    @event = Event.find(params[:id])
    @event.destroy

    redirect_to events_path
  end

  private

  def event_params
  	params.require(:event).permit(:title, :description, :time, :place, :notes, :hosted_by, group_participants: [])
  end
end
