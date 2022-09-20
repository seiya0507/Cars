class Public::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @car = Car.find(params[:car_id])
    @comment = Comment.new(comment_params)
    @comment.car_id = @car.id
    @comment.user_id = current_user.id
    @comment.save
  end

  def destroy
    @car = Car.find(params[:car_id])
    comment = @car.comments.find(params[:id])
    comment.destroy
  end


  private

  def comment_params
    params.require(:comment).permit(:comment, :car_id, :user_id)
  end

end
