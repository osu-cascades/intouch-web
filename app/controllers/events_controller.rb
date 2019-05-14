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

    @event.groups.clear
    @event.users.clear

    @groups = Group.where(id: params[:event][:group_participants])
    group_participants = []
    user_recipients = []
    @groups.each do |group|
      @event.groups << group
      group_participants << group.name
      @users = group.users
      @users.each do |user|
        user_recipients << user
      end
    end
    @event.group_participants = group_participants.join(', ')
    user_recipients.uniq!(&:username)
    user_recipients.each do |user|
      @event.users << user
    end

    if @event.save
      flash[:success] = 'Event updated!'
      redirect_to event_path(@event)
    end
  end

  def create
    @event = Event.new(event_params)
    @groups = Group.where(id: params[:event][:group_participants])
    group_participants = []
    user_recipients = []
    @groups.each do |group|
      @event.groups << group
      group_participants << group.name
      @users = group.users
      @users.each do |user|
        user_recipients << user
      end
    end
    @event.group_participants = group_participants.join(', ')
    user_recipients.uniq!(&:username)
    user_recipients.each do |user|
      @event.users << user
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
  	params.require(:event).permit(:title, :description, :time, :place, :notes, :hosted_by, :color, group_participants: [])
  end
end
