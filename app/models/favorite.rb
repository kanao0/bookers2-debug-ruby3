class Favorite < ApplicationRecord
  # ユーザー、bookに属する
  belongs_to :user
  belongs_to :book
end
