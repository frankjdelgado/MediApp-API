# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:

Medication.delete_all
User.delete_all
Treatment.delete_all


#Users


User.create(:name => "admin" , :email => "mail@gmail.com", :password => "123456", :role => 1)
User.create(:name => "frank" , :email => "frank@gmail.com", :password => "123456", :role => 0)
User.create(:name => "luis" , :email => "luis@gmail.com", :password => "123456", :role => 0)
User.create(:name => "User" , :email => "user@gmail.com", :password => "123456", :role => 1)
User.create(:name => "manu" , :email => "mail0@gmail.com", :password => "123456", :role => 0)

#Medications

Medication.create(:name => "Vicodion" , :description => "Powerfull painkiller")
Medication.create(:name => "Acetaminofen" , :description => "Anti-Flu medicine")
Medication.create(:name => "Malox" , :description => "Medicine for stomach-ache")
Medication.create(:name => "Insuline" , :description => "Health supplement against diabetus")
Medication.create(:name => "Cortisol" , :description => "Awesome does it all medicine")
Medication.create(:name => "Peniciline" , :description => "Fungus based medicine against deseases")
Medication.create(:name => "Festal" , :description => "Digestive")




#treatments

3.times do |i|
	Treatment.create(
					start: DateTime.now.to_date ,
					finish: DateTime.now.midnight, 
					hour: 10.minutes.ago.strftime("%I:%m %p"),
					frequency: 1,
					user_id: User.first.id,
					medication_id: Medication.first.id
				)
 end
