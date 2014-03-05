require 'securerandom'

class Member < ActiveRecord::Base
	include Clearance::User

	scope :officers, -> { where(officer: true) }
	scope :competitive, -> { where(competitive: true) }
	scope :non_competitive, -> { where(competitive: false) }
	scope :alphabetical, -> { order(:first_name) }

	before_save :set_email

	validates :first_name, :last_name, :case_id, :email, :year, presence: true, allow_blank: false
	validates :case_id, :email, uniqueness: true

	YEARS = ['Freshman', 'Sophomore', 'Junior', 'Senior']
	OFFICER_POSITIONS = ['President', 'Vice President', 'Treasurer', 'Secretary']

	# generates a random string of length 8 containing numbers, letters and some symbols
	def self.random_password
		SecureRandom::base64 6
	end

	def full_name
		"#{first_name} #{last_name}"
	end

	def competitive_as_string
		competitive ? "Yes" : "No"
	end

	def officer_as_string
		officer ? "Yes" : "No"
	end

	private
		def set_email
			email = "#{case_id}@case.edu" unless email != ''
		end
end
