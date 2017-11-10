class GroupsController < ApplicationController

  def show
    @group = Group.find(params[:id])
  end

  def new
  end
end