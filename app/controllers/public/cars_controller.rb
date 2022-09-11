class Public::CarsController < ApplicationController
  def new
    @car = Car.new
  end

  def create
    @user = current_user
    @new_car = Car.new(car_params)
    @new_car.user_id = current_user.id
    if @new_car.save
       redirect_to car_path(@new_car.id)
       flash[:notice] = "レビューを投稿しました！"
    else
       @cars = Car.all
       render :index
    end
  end

  def index
    @cars = Car.all
    @new_car = Car.new
    @user = current_user
  end

  def show
    @car = Car.find(params[:id])
    @new_car = Car.new
    @user = current_user
    @car_user = @car.user
  end

  def edit
    @car = Car.find(params[:id])
    unless @car.user == current_user
      redirect_to cars_path
    end
  end

  def update
    @car = Car.find(params[:id])
    if @car.update(car_params)
       redirect_to car_path(@car.id)
       flash[:notice] = "レビュー投稿内容を更新しました！"
    else
       render :edit
    end
  end

  def destroy
    @car = Car.find(params[:id])
    @car.destroy
    redirect_to cars_path
    flash[:notice] = "レビュー投稿を削除しました！"
  end



  private

  def car_params
    params.require(:car).permit(:title, :body, :image)
  end

end
