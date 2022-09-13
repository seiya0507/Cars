class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @car = Car.find(params[:car_id])
    favorite = @car.favorites.new(user_id: current_user.id)
    favorite.save
  end

  def destroy
    @car = Car.find(params[:car_id])
    favorite = @car.favorites.find_by(user_id: current_user.id)
    favorite.destroy
  end
end
