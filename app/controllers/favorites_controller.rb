class FavoritesController < ApplicationController
  
  def create
    # これからいいねをする本の情報
    book = Book.find(params[:book_id])
    # 今のユーザーからいいねの情報を取得して新しいいいねを作成する（favoriteモデルの中のbook_idに対して：これからいいねをする本の情報　を代入）
    favorite = current_user.favorites.new(book_id: book.id)
    # いいねを保存
    favorite.save
    # ページを切り替え
    redirect_to book_path(book.id)
  end
 
 
  def destroy
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    favorite.destroy
    redirect_to book_path(book.)
  end
 
end

 