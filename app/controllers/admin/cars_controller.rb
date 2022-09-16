class Admin::CarsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @cars = Car.all
  end

  def show
    @car = Car.find(params[:id])
    @car_user = @car.user
  end

  def destroy
    def destroy
    @car = Car.find(params[:id])
    @car.destroy
    redirect_to admin_cars_path
    flash[:notice] = "レビュー投稿を削除しました。"
    end
  end
end
