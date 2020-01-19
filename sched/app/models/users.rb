class User < ActiveRecord::Base
    has_secure_password
    validates_presence_of :username, :password, :email
    validates_uniqueness_of :username, :email
    has_many :events
    has_many :uploads
    has_many :notes
end