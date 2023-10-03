class SearchesController < ApplicationController
  
  def search
    # 検索したモデル(book/user)を@modelに代入
    @model = params[:model]
    # ユーザーが入力したワードを@contentへ代入
    @content = params[:content]
    # ユーザーが選択した検索方法(部分一致とか完全一致)を@methodに代入
    @method = params[:method]
    
    # 選択したモデルに応じて検索を実行
    if @model  == "user"
      @records = User.search_for(@content, @method)
    else
      @records = Book.search_for(@content, @method)
    end
  end  
end
