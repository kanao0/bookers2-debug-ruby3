class Book < ApplicationRecord
  
  # ユーザーに属する
  belongs_to :user
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
end
