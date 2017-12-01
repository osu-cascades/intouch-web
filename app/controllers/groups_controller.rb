class GroupsController < ApplicationController

  #before_action :logged_in_user

  def index
    @groups = Group.all
  end

  def show
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      flash[:success] = "New group created!"
      redirect_to groups_path
    else
      render 'new'
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update_attributes(group_params)
      flash[:success] = "Group updated"
      redirect_to groups_path
    else
      render 'edit'
    end
  end

  def destroy
    Group.find(params[:id]).destroy
    flash[:success] = "Group deleted from database"
    redirect_to groups_path
  end

  private

    def group_params
      params.require(:group).permit(:name)
    end

end