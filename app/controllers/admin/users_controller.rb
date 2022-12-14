class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @cars = @user.cars.order(created_at: :desc)
    @car = @user.cars.order(created_at: :desc)
  end

end
