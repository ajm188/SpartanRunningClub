# Load the Rails application.
require File.expand_path('../application', __FILE__)

mail_env = File.join(Rails.root, 'config', 'mail_env.rb')
load(mail_env) if File.exists?(mail_env)


# Initialize the Rails application.
SRC::Application.initialize!
