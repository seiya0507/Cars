class Admin::FreezesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.joins(:freeze).where.not(freeze: nil).order(:id)
  end

  def create
    User.find(params[:user_id]).create_freeze
    flash[:notice] = "登録ユーザーを凍結しました。"
    redirect_to admin_freezes_path
  end

  def destroy
    Freeze.where(user_id: params[:user_id]).destroy_all
    flash[:notice] = "登録ユーザーの凍結を解除しました。"
    redirect_to admin_users_path
  end
end
