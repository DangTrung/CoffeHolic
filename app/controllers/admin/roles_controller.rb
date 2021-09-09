class Admin::RolesController < Admin::BaseController
  before_action :load_role, only: [:edit, :update, :destroy]
  load_and_authorize_resource
  before_action :load_permissions

  def index
    @role = Role.includes(:permissions).all
  end

  def new
    @role = Role.new
  end

  def create
    @role = Role.new(role_params)
    @name = Permission.pluck(:subject_class).uniq
    permission_ids = @name.map{ |i| params[i][:permission_ids]}.flatten.uniq

    if @role.save
      byebug
      @role.permission_ids = permission_ids
      flash[:success] = "Role create"
      redirect_to admin_roles_path
    else
      render :new
    end
  end

  def edit; end

  def update
    @name = Permission.pluck(:subject_class).uniq
    permission_ids = @name.map{ |i| params[i][:permission_ids]}.flatten.uniq
    byebug
    if @role.update(attributes: role_params, permission_ids: permission_ids)
      flash[:success] = "updated"
      redirect_to admin_roles_path
    else
      flash.now[:danger] = "Fails"
      render :edit
    end
  end

  def destroy
    @role.destroy
    flash[:success] = "destroyed"
    redirect_to request.referer
  end

  private

  def role_params
    params.require(:role).permit(:name)
  end

  def load_role
    @role = Role.find(params[:id])
  end
end
