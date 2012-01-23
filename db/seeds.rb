# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

Domain.create!(:title => "My Outline") if Domain.count == 0

Domain.first.users.create(:login => "admin", :password => "admin", :password_confirmation => "admin", :email => "example@example.org")
Domain.first.users.create(:login => "demo", :password => "demo", :password_confirmation => "demo", :email => "example2@example.org")
