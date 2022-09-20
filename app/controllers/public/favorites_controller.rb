class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:create, :destroy]

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


  private

  def ensure_guest_user
    @user = current_user
    if @user.name == "guestuser"
      redirect_to cars_path, notice: 'ゲストユーザーはいいねできません。'
    end
  end

end
