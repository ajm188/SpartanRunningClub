require 'securerandom'
require_relative 'time'

class Member < ActiveRecord::Base
	include Clearance::User

	YEARS = %w(Freshman Sophomore Junior Senior)
	OFFICER_POSITIONS = %w(President Vice\ President Treasurer Secretary)

	scope :officers, -> { where(officer: true) }
	scope :competitive, -> { where(competitive: true) }
	scope :non_competitive, -> { where(competitive: false) }
	scope :alphabetical, -> { order(:first_name) }

	before_validation :set_email, if: -> { self.email.blank? }

	validates :first_name, :last_name, :case_id, :year, :competitive, :officer,
		presence: true, allow_blank: false
	validates :year,
		inclusion: { in: YEARS }
	validates :case_id,
		length: { maximum: 6 },
		format: { with: /[a-z]+\d+/, message: 'should be a valid case_id.' }
	validates :case_id, :email,
		uniqueness: true
	# Validations for officers
	validates :position,
		presence: true, allow_blank: false, if: -> { self.officer }
	validates :position,
		inclusion: { in: OFFICER_POSITIONS }, if: -> { self.officer }

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

	# Set the member's email using their case id if it's not already defined
	def set_email
		self.email = "#{case_id}@case.edu"
	end
end
