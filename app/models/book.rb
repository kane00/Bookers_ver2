class Book < ApplicationRecord
	acts_as_taggable #追加
  # acts_as_taggable_on :tags　と同じ意味のエイリアス
  # tags のなかにIDやら名前などが入る。イメージ的には親情報。


	belongs_to :user

	def books
	  return Book.find_by(user_id: self.id)
	end

	# 画像投稿機能
  	attachment :profile_image

	# バリデーションチェック、タイトルに何か書かれているか
	validates :title, presence: true
	# バリテーションチェック、空白出ないか＋Max199文字まで
	validates :body, 
		presence: true, 
		length: { maximum: 199 }
		#→validates :body, length: 1..200　の書き方もある
end
