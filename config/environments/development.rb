Simple::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
	config.cache_classes = false

	config.after_initialize do
		# ActiveRecord::Base.logger = Rails.logger.clone
		# ActiveRecord::Base.logger.level = Logger::INFO
	end
#	unicorn.worker_processes = 3
end
