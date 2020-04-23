class Book < ApplicationRecord

	belongs_to :user

	def books
	  return Book.find_by(user_id: self.id)
	end
	# バリデーションチェック、タイトルに何か書かれているか
	validates :title, presence: true
	# バリテーションチェック、空白出ないか＋Max199文字まで
	validates :body, 
		presence: true, 
		length: { maximum: 199 }
		#→validates :body, length: 1..200　の書き方もある
end
