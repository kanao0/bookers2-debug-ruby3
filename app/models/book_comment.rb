class BookComment < ApplicationRecord
  # ユーザーと投稿したBookに属する
  belongs_to :user
  belongs_to :book
  
  # 空のコメントはだめだよー
  validates :comment, presence: true
end
