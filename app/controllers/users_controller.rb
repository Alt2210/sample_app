class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(show new create)
  before_action :find_user, except: %i(index new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def show
    @pagy, @microposts = pagy(@user.microposts.newest,
                              limit: Settings.pagination.microposts_per_page_10)
  end

  def index
    @pagy, @users = pagy(User.newest,
                         limit: Settings.pagination.user_per_page)
  end

  def new
    @user = User.new
  end

  def update
    if @user.update user_params
      flash[:success] = t("activerecord.flash.actions.update")
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t("activerecord.flash.info.activate")
      redirect_to root_url, status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def destroy
    if @user.destroy
      flash[:success] = t("activerecord.flash.actions.destroy")
    else
      flash[:danger] = t("activerecord.flash.danger.delete_fail")
    end
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit :name, :email,
                                 :password,
                                 :password_confirmation
  end

  def find_user
    @user = User.find_by(id: params[:id])
    return if @user

    flash[:warning] = t("activerecord.flash.warnings.not_found_user")
    redirect_to root_path
  end

  def correct_user
    return if current_user?(@user)

    flash[:danger] = t("activerecord.flash.danger.edit_permission_required")
    redirect_to root_url
  end
end
