class User < ApplicationRecord
  attr_accessor :remember_token
  before_save { self.email = self.email.downcase }
  
  #validations
  validates :name, :email, presence: true
  validates :email, uniqueness: {case_sensitive: false}

  #Associations
  has_many :surveys, dependent: :destroy
  has_one :config, class_name: "UserConfig", dependent: :destroy
  has_many :scheduled_surveys, class_name: "UserSurveySchedule", dependent: :destroy
  
  #Password
  has_secure_password
  validates :password, presence: true
  
  #Instance methods
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_token, User.digest(remember_token))
  end
  
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  def forget
    update_attribute(:remember_token, nil)
  end
  
  #Class methods
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                              BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  
    
end
