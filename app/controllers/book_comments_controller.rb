class BookCommentsController < ApplicationController
  def create
    # どの本にコメントをするかを探す
    book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book_id = book.id
    @comment.save
    # コメントしたら新しい詳細ページへ
    # redirect_to book_path(book.id)  
  end
  
  
  
  def destroy
    @comment = BookComment.find(params[:id])
    @comment.destroy
  end
  
  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
  
end
