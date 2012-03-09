# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

Domain.create!(:title => "Outline") if Domain.count == 0

Domain.first.users.create(:login => "admin", :password => "admin", :password_confirmation => "admin", :email => "example@example.org")
Domain.first.users.create(:login => "demo", :password => "demo", :password_confirmation => "demo", :email => "example2@example.org")

Project

user = Domain.first.users.first
["Diploma", "Disseration", "Award Show", "Trip to Australia"].each do |title|
  opts = {:title => title}
  record = Domain.first.projects.create(opts)
  record.user = user
  record.save
end

Page

user = Domain.first.users.first
["A new page", "Another page", "Homepage", "Turn the page"].each do |title|
  opts = {:title => title}
  record = Domain.first.pages.create(opts)
  record.user = user
  record.save
end
