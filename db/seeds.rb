# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

	Contributor.create!({firstName: 'Alfredo', lastName: 'Segundo', email: 'alfredocavalcanti@gmail.com', email_confirmation: 'alfredocavalcanti@gmail.com'})
	Contributor.create!({firstName: 'Ana Cecília', lastName: 'Vieira', email: 'cecivieira@gmail.com', email_confirmation: 'cecivieira@gmail.com'})