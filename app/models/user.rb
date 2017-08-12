class User < ApplicationRecord
    #presence
    validates :name, :email, presence: true
    
    
    #uniqueness
    validates :email, uniqueness: {case_sensitive: false}
    
    #format
    before_save { self.email = self.email.downcase }
    
    has_secure_password
    validates :password, presence: true
end
