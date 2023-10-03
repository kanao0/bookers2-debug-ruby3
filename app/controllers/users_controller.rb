class UsersController < ApplicationController
  # edit,updateのアクション前にensure_correct_userアクション実行
  before_action :ensure_correct_user, only: [:edit,:update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    # 持ってきたデータを入れる箱みたいなかんじ？
       @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render :edit
    end
  end
  
  
  
  

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

 # 他人のユーザ情報編集画面にいけないようにするやつ
# 勝手に編集しようとする人は自分のuser/indexページへ行く
  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
  

end
