class Micropost < ApplicationRecord
    #belongs_to :userによって、Micropostのインスタンスでインスタンスメソッドuserが使えるようになる
    #インスタンスメソッドuserの戻り値は、Userのインスタンス。
  belongs_to :user
  validates :content, presence: :true, length: {maximum: 255}
end
