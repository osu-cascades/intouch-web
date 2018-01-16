class RolesController < ApplicationController
  
before_action :authenticate_user!
  def index
    @roles = Role.all
  end

  def new
    @role = Role.new
  end

  def edit
    @role = Role.find(params[:id])
  end

  def create
    @role = Role.new(role_params)
    if @role.save
      flash[:success] = "New Role created!"
      redirect_to roles_path
    else
      render 'new'
    end
  end

  def update
    @role = Role.find(params[:id])
    if @role.update_attributes(role_params)
      flash[:success] = "Role updated"
      redirect_to roles_path
    else
      render 'edit'
    end
  end

  def destroy
    Role.find(params[:id]).destroy
    flash[:success] = "Role deleted from database"
    redirect_to roles_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = Role.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def role_params
      params.require(:role).permit(:name)
    end
end
