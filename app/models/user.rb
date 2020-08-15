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
                    
    has_many :relationships
    #既存のモデルクラスに対するリレーションではない。からthrough:を付け加えてる。さらに、参照先のID候補は二つあるのでそれをsource:で指定している
    has_many :followings, through: :relationships, source: :follow
    has_many :reverses_of_relationships, class_name: "Relationship", foreign_key: "follow_id"
    has_many :followers, through: :reverses_of_relationships, source: :user
                    
    
    def follow(other_user)
        unless self == other_user
            self.relationships.find_or_create_by(follow_id: other_user.id)
        end
    end

    
    def unfollow(other_user)
        relationship = self.relationships.find_by(follow_id: other_user.id)
        relationship.destroy if relationship
    end
    
    def following?(other_user)
        self.followings.include?(other_user)
    end
    
    def feed_microposts
        Micropost.where(user_id: self.following_ids + [self.id])
    end

end
