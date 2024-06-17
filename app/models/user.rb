class User < ApplicationRecord
    has_many :microposts, dependent: :destroy
    has_many :active_relationships, class_name: "Relationship", 
                                    foreign_key: "follower_id", 
                                    dependent: :destroy
    has_many :passive_relations, class_name: "Relationship",
                                 foreign_key: "followed_id",
                                 dependent: :destroy
    has_many :followers, through: :passive_relations, source: :follower
    has_many :following, through: :active_relationships, source: :followed
    attr_accessor :remember_token, :activation_token, :reset_token
    before_save :downcase_email
    before_create :create_activation_digest
    validates(:name, presence: true, length: { maximum: 50 })
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                format: { with: VALID_EMAIL_REGEX },
                uniqueness: true
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine::cost
        BCrypt::Password.create(string, cost: cost)
    end

    def User.new_token
        SecureRandom.urlsafe_base64
    end

    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
        remember_digest
    end

    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end

    def forget
        update_attribute(:remember_digest, nil)
    end

    def session_token
        remember_digest || remember
    end

    def activate
        update_columns(activated: true, activated_at: Time.zone.now)
    end

    def send_activation_email
        UserMailer.account_activation(self).deliver_now
    end

    def create_reset_digest
        self.reset_token = User.new_token
        update_columns(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
    end

    def send_password_reset_email
        UserMailer.password_reset(self).deliver_now
    end

    def password_reset_expired?
        reset_sent_at < 2.hours.ago
    end

    def feed
        part_of_feed = "relationships.follower_id = :id or microposts.user_id = :id"
        Micropost.left_outer_joins(user: :followers)
                 .where(part_of_feed, { id: id }).distinct
                 .includes(:user, image_attachment: :blob)
    end

    def follow(other_user)
        following << other_user unless self == other_user
    end

    def unfollow(other_user)
        following.delete(other_user)
    end

    def following?(other_user)
        following.include?(other_user)
    end

    private

        def downcase_email
            self.email.downcase!
        end

        def create_activation_digest
            self.activation_token = User.new_token
            self.activation_digest = User.digest(activation_token)
        end
end