Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to =>"homes#top"
  devise_for :users
  get "home/about"=>"homes#about"


  # booksのルーティングindex,show,edit,create,destroy,update作成
  # 投稿された本に対してコメント、いいねをするから親子関係にしてあげる
  # いいねは画面移動なしresource、コメントは詳細画面へ移動するからresources
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  
  resources :users, only: [:index,:show,:edit,:update] do
   # ネストさせる
  # フォローする/フォロー削除は画面移動なしresource
    resource :relationships, only: [:create, :destroy]
    # 一覧画面に行くためのやつ
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
