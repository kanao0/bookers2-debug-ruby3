class Book < ApplicationRecord
  
  # ユーザーに属する
  belongs_to :user
  # Bookは複数いいねもらえるよ？？
  has_many :favorites, dependent: :destroy
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  # よく分からん
  # いいねをしてるかしてないかの判定（本を投稿した人のID：いいねをしてるかしてないかを判断したいユーザーのID）
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
end
