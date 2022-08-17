class User < ApplicationRecord
    has_many :microposts
    before_save { self.email = email.downcase }
    validates :name, presence: true, length: { maximum: 255 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email,   presence: true, 
                        format: { with: VALID_EMAIL_REGEX },
                        uniqueness: true
    has_secure_password
    # validates :password, presence: true, length: { minimum: 6 }
    # validates :password_confirmation, presence: true, length: { minimum: 6 }

    # validate :check_email_and_password

    # def check_email_and_password
    #     errors.add(:password, "Password != password_confirm") if password == password_confirm
    # end
end
