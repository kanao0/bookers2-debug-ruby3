class Relationship < ApplicationRecord
# １人のユーザーはたくさんのユーザーをフォローできるbelongs_to :User
# １人のユーザーはたくさんのユーザーにフォローされるbelongs_to :User
# （User:User）でよくわからなくなるから代わりの名前を使う？？
# ※follower
# ※followed
  
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
end
