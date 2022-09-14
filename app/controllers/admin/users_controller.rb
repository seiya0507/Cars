class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @cars = @user.cars
    @car = @user.cars
  end

end
