class User < ActiveRecord::Base
	attr_accessible :email, :password, :username, :auth_token
	has_secure_password
end

