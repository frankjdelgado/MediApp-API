# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(:name => "mela" , :email => "mail@gmail.com", :password => "123456", :role => 1)
User.create(:name => "manu" , :email => "mail0@gmail.com", :password => "123456", :role => 1)

# User(id: integer, name: string, email: string, password_digest: string, role: integer, created_at: datetime, updated_at: datetime) 