class User < ApplicationRecord
    #has_many :micropostsによって、userインスタンスでインスタンスメソッドmicropostsが使えるようになる
    #インスタンスメソッドmicropostsの戻り値は、あるUserの投稿したMicropostの全件データ.

    has_many :microposts
    before_save { self.email.downcase! }
    has_secure_password
    validates :name, presence: true, length: { maximum: 50}
    validates :email, presence: true, length: {maximum: 255},
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
                    

end
