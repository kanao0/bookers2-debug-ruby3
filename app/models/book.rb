class Book < ApplicationRecord

  # ユーザーに属する
  belongs_to :user
  # Bookは複数いいねもらえるよ？？
  has_many :favorites, dependent: :destroy
  # 1つの本の投稿に対して複数コメントできるよ、本の投稿消したらコメントも消えるよー
  has_many :book_comments, dependent: :destroy

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  # カラムデータの取り出し方を記入
  # order = データの取り出し　created_at = 投稿日のカラム　desc = 昇順　asc = 降順
  # :latest : 最新のものから順に並べる
  scope :latest, -> {order(created_at: :desc)}
  # :old : 古いものから順に並べる
  scope :old, -> {order(created_at: :asc)}
  # :star_count : 星の数が多い順に並べる
  scope :star_count, -> {order(star: :desc)}

  # 検索方法に合わせて処理をわける
  def self.search_for(content, method)
    if method == 'perfect'
      Book.where(title: content)
    elsif method == 'forward'
      Book.where('title LIKE ?', content + '%')
    elsif method == 'backward'
      Book.where('title LIKE ?', '%' + content)
    else
      Book.where('title LIKE ?', '%' + content + '%')
    end
  end


  # ★誰が★いいねをしてるかしてないかの判定（本を投稿した人のID：いいねをしてるかしてないかを判断したいユーザーのID）
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end
