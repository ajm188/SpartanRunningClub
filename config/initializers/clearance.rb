Clearance.configure do |config|
  config.cookie_domain = 'case.edu'
  config.cookie_expiration = lambda { |cookies| 1.year.from_now.utc }
  config.cookie_path = '/'
  config.httponly = false
  config.mailer_sender = 'running-club@case.edu'
  config.password_strategy = Clearance::PasswordStrategies::BCrypt
  config.redirect_url = '/'
  config.secure_cookie = false
  config.sign_in_guards = []
  config.user_model = Member
end
