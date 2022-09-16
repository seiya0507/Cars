class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]

  def index
    @users = User.all
    @user = current_user
    @new_car = Car.new
  end

  def show
    @user = User.find(params[:id])
    @cars = @user.cars
    @new_car = Car.new
    @car = @user.cars
  end

  def edit
    @user = User.find(params[:id])
    unless @user == current_user
    redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       redirect_to user_path(@user.id)
       flash[:notice] = "ユーザー情報を更新しました！"
    else
       render :edit
    end
  end

  def unsubscribe
    @user = User.find_by(email: params[:email])
  end

　#退会アクション
  def withdraw
    @user = User.find_by(email: params[:email])
    current_user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会しました。またのご利用をお待ちしております。"
    redirect_to root_path
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :email)
  end


  #ゲストユーザーの制限メソッド
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to cars_path, notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end
end
