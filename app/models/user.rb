class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  # ユーザー1人につき1つのプロフィールイメージ
  has_one_attached :profile_image  
  # 1人のユーザーは複数の本を投稿できるよー、ユーザーが消えたらそのユーザーのBookも消えるよ
  has_many :books, dependent: :destroy
  # 1人のユーザーは複数いいねできるよー、ユーザーが消えたらそのユーザーのいいねも消えるよ
  has_many :favorites, dependent: :destroy
  # 1人のユーザーは複数コメントできるよー、ユーザーが消えたらそのユーザーのコメントも消えるよ
  has_many :book_comments, dependent: :destroy

  # ※follower_id : フォローするユーザー
  # ※followed_id : フォローされるユーザー
  # foreign_key参照する外部キー
  
  # あるユーザーをフォローしている人(フォロワー)の一覧を取得するアソシエーション
  # 　フォローした、されたの関係
  has_many :reverse_of_relationships, class_name:  "Relationship",
                                      foreign_key: "followed_id",
                                      dependent:   :destroy
  # 一覧画面で使う
  has_many :followers, through: :reverse_of_relationships, source: :follower
  
  # あるユーザーがフォローしている人(フォロイー)の一覧を取得するアソシエーション
  # フォローした、されたノ関係
  has_many :relationships, class_name:  "Relationship",
                           foreign_key: "follower_id",
                           dependent:   :destroy
  # 一覧画面で使う
  has_many :followings, through: :relationships, source: :followed

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }
  
   # フォローしたときの処理
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  # フォローを外すときの処理
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  # フォローしているか判定、してたらtrue
  def following?(user)
    followings.include?(user)
  end
  
  def self.search_for(content, method)
    if method == 'perfect'
      User.where(name: content)
    elsif method == 'forward'
      User.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      User.where('name LIKE ?', '%' + content)
    else
      User.where('name LIKE ?', '%' + content + '%')
    end
  end  
  
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end
