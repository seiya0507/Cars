class Admin::CarsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @cars = params[:tag_id].present? ? Tag.find(params[:tag_id]).cars.order(created_at: :desc) : Car.all.order(created_at: :desc)
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
