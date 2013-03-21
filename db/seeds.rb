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
