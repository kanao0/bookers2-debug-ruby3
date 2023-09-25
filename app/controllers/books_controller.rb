class BooksController < ApplicationController
  # edit,updateアクション前にensure_correct_user実行
before_action :ensure_correct_user, only: [:edit, :update]

  def show
    # 本の情報をURLから取得
    @book = Book.find(params[:id])
    # 本を投稿したユーザーの情報＊これはUserinfoで使う
    @user = @book.user
    # Book投稿のための箱を用意
    @book_new = Book.new
  end

  def index
    @user = current_user
    # 投稿した本のデータを取得
    @books = Book.all
    # データを入れる箱
    @book = Book.new
  end

  def create
    # 投稿されたデータを入れる
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
# 他人のbook編集画面にいけないようにするやつ
# 勝手に編集しようとする人は自分のbook/indexページへ行く
  def ensure_correct_user
    @book = Book.find(params[:id])
    # unless book.user.id == current_user.id
    unless @book.user == current_user
      redirect_to books_path
    end
  end

  
end
