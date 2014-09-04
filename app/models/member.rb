require 'securerandom'

class Member < ActiveRecord::Base
	include Clearance::User

	FRESHMAN = "Freshman"
	SOPHOMORE = "Sophomore"
	JUNIOR = "Junior"
	SENIOR = "Senior"
	YEARS = [FRESHMAN, SOPHOMORE, JUNIOR, SENIOR]

	PRESIDENT = "President"
	VICE_PRESIDENT = "Vice President"
	TREASURER = "Treasurer"
	SECRETARY = "Secretary"
	OFFICER_POSITIONS = [PRESIDENT, VICE_PRESIDENT, TREASURER, SECRETARY]

	scope :officers, -> { where(officer: true) }
	scope :competitive, -> { where(competitive: true) }
	scope :non_competitive, -> { where(competitive: false) }
	scope :alphabetical, -> { order(:first_name) }

	has_many :followings, dependent: :destroy
	has_many :followables, through: :followings
	# Members can follow Events
	has_many :events, through: :followings,
		source: :followable, source_type: Event.to_s
	has_many :member_meetings, dependent: :destroy
	has_many :invited_meetings, ->{ where("relationship = ?",
		MemberMeeting::INVITEE) }, through: :member_meetings, source: :meeting
	has_many :attended_meetings, ->{ where("relationship = ?",
		MemberMeeting::ATTENDEE) }, through: :member_meetings, source: :meeting

	has_attached_file :avatar,
		styles: { thumb: '20x20#', reg: '120x120#' },
		default_url: '/images/members/missing_:style.jpg'
	validates_attachment_content_type :avatar,
		content_type: /\Aimage/

	validates :first_name, :last_name, :case_id, :year,
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
	# Password validation
	validates :password,
		presence: true, allow_blank: false, on: :create

	before_validation :set_email, if: -> { self.email.blank? }

	def self.update_year
		Member.where('year != ?', SENIOR).each do |member|
			member.update_attributes({
				year: YEARS[YEARS.index(member.year) + 1]
			})
		end
	end

	# generates a random string of length 8
	def self.random_password
		SecureRandom::base64 6
	end

	def full_name
		"#{first_name} #{last_name}"
	end

	def competitive_string
		competitive ? "Yes" : "No"
	end

	def officer_string
		officer ? "Yes" : "No"
	end

	# Returns true if this member follows followable. False otherwise.
	def follows? followable
		Following.exists?(
			followable_id: followable.id,
			followable_type: followable.class.to_s,
			member_id: self.id
		)
	end

	private

	# Set the member's email using their case id if it's not already defined
	def set_email
		self.email = "#{case_id}@case.edu"
	end
end
