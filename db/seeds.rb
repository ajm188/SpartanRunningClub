# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Member.create!(
  :first_name  => 'Andrew',
  :last_name   => 'Mason',
  :case_id     => 'ajm188',
  :email       => 'ajm188@case.edu',
  :password    => 'password',
  :year        => 'Sophomore',
  :competitive => true,
  :position    => Member::OFFICER_POSITIONS[0],
  :officer     => true
)
