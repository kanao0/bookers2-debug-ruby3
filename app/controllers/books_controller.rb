class BooksController < ApplicationController

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
      render 'index'
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
      render "edit"
    end
  end

  def delete
    @book = Book.find(params[:id])
    @book.destoy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
