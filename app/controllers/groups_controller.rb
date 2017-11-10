class GroupsController < ApplicationController

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
      redirect_to '/groups/show'
    else
      render 'new'
    end
  end

  private

    def group_params
      params.require(:group).permit(:name)
    end

end