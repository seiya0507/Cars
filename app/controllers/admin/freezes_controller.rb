class Admin::FreezesController < ApplicationController
  def index
    @users = User.joins(:freeze).where.not(freeze: nil).order(:id)
  end

  def create
    User.find(params[:user_id]).create_freeze
    redirect_to admin_users_path
  end

  def destroy
    Freeze.where(user_id: params[:user_id]).destroy_all
    redirect_to admin_users_path
  end
end
