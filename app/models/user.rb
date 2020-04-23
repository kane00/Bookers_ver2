class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Userとの関連付け (1:N)
  has_many :books, dependent: :destroy

  def books
	  return Book.where(user_id: self.id)
  end
  # 画像投稿機能
  attachment :profile_image
  # 名前入力設定 名前は書かれているか＋最低2〜最高20字
  validates :name, 
    presence: true,
    length: { minimum: 2, maximum: 20 }
  # email入力設定 文字が入っているか+一意性（メールアドレスが他のユーザーと被らないように）の検証
  validates :email, 
    presence: true,
    uniqueness: true
  # introductionはMax50字まで
  validates :introduction, 
  	length: { maximum: 50 }
end
