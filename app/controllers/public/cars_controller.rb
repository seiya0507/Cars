class Public::CarsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:create]

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

  def index #タグ検索で絞り込み取得、それ以外は全取得                           #データの順序を変更、製作日時で降順に並び替え
    @cars = params[:tag_id].present? ? Tag.find(params[:tag_id]).cars : Car.all.order(created_at: :desc)
    @new_car = Car.new
    @user = current_user
  end

  def show
    @car = Car.find(params[:id])
    @new_car = Car.new
    @user = current_user
    @car_user = @car.user
    @comment = Comment.new
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
    params.require(:car).permit(:title, :body, :image, :star, tag_ids: [])
  end


  def ensure_guest_user
    @user = current_user
    if @user.name == "guestuser"
      redirect_to cars_path, notice: 'ゲストユーザーは投稿できません！'
    end
  end
end
