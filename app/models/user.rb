class User < ActiveRecord::Base
	attr_accessible :email, :password, :username, :auth_token, :nume, :prenume

	has_many :posts

	has_secure_password
end

