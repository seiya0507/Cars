class Admin::CarsController < ApplicationController
  def index
    @cars = Car.all
  end

  def destroy
    def destroy
    @car = Car.find(params[:id])
    @car.destroy
    redirect_to admin_cars_path
    flash[:notice] = "レビュー投稿を削除しました！"
    end
  end
end
