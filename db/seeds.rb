# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Member.delete_all

Member.create!(
	first_name: 'Andrew',
	last_name: 'Mason',
	case_id: 'ajm188',
	year: 'Sophomore',
	competitive: true,
	officer: true,
	position: 'Vice President',
	email: 'ajm188@case.edu',
	password: 'password')