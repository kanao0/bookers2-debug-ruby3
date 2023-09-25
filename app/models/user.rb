class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  # 1人のユーザーは複数の本を投稿できるよー、ユーザーが消えたらそのユーザーのBookも消えるよ
  has_many :books, dependent: :destroy
  # 1人のユーザーは複数いいねできるよー、ユーザーが消えたらそのユーザーのいいねも消えるよ
  has_many :favorites, dependent: :destroy
  # ユーザー1人につき1つのプロフィールイメージ
  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  # def get_profile_image(width, height)
  #   unless profile_image.attached?
  #     file_path = Rails.root.join('app/assets/images/no-image.jpg')
  #     profile_image.attach(io: File.open(file_path), filename: 'no-image.jpg', content_type: 'image/jpeg')
  #   end
  #   profile_image.variant(resize_to_limit: [width, height]).processed
  # end
  
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end
