class User < ActiveRecord::Base
  before_save {self.email=email.downcase} #self.email=self.email.downcase
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX=/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
                    length: {maximum: 255},
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false} #uniqueness: true is inferred
  has_secure_password
  validates :password, length: {minimum: 6}
                    
end
