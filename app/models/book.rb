class Book < ApplicationRecord
  
  # ユーザーに属する
  belongs_to :user
  # Bookは複数いいねもらえるよ？？
  has_many :favorites, dependent: :destroy
  # 1つの本の投稿に対して複数コメントできるよ、本の投稿消したらコメントも消えるよー
  has_many :book_comments, dependent: :destroy
  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  
  # ★誰が★いいねをしてるかしてないかの判定（本を投稿した人のID：いいねをしてるかしてないかを判断したいユーザーのID）
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
end
