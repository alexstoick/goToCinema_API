class User < ActiveRecord::Base
	attr_accessible :email, :password, :username, :auth_token
	has_secure_password
end

#$2a$10$/mbcmb8qFZDbnglZgBNi8eAvIrGM3ryQds83B9tq/Ph5wYklMNWjy