# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

%w(Customer Administrator).each { |role| Role.create!(:name => role)}

#Associative array takes in the Role Customer & Administrator loops through each of them and creates a the role.

b = User.create!( :first_name => "BACKDOOR",
                  :last_name => "Backdoor account",
                  :email => "dpatterson2008@hotmail.com",
                  :password => "Clyde_01",
                  :password_confirmation => "Clyde_01",
)
b.roles << Role.first
b.roles << Role.last
b.save
