# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Frequency.delete_all
MedicationType.delete_all
Medication.delete_all
Unit.delete_all
User.delete_all
Treatment.delete_all

#Users

User.create(:name => "admin" , :email => "mail@gmail.com", :password => "123456", :role => 0)
User.create(:name => "frank" , :email => "frank@gmail.com", :password => "123456", :role => 1)
User.create(:name => "luis" , :email => "luis@gmail.com", :password => "123456", :role => 1)
User.create(:name => "User" , :email => "user@gmail.com", :password => "123456", :role => 2)


# Frequecy

	Frequency.create(value: "Daily")
	Frequency.create(value: "Weekly")
	Frequency.create(value: "Monthly")
	Frequency.create(value: "After Eating")
	Frequency.create(value: "times a day")
	Frequency.create(value: "Every X hours")

# MEdication Type
# guide: http://www.macmillandictionary.com/thesaurus-category/british/types-and-forms-of-medicine

	MedicationType.create(value: "Liquid")
	MedicationType.create(value: "Tablet")
	MedicationType.create(value: "Capsules")
	MedicationType.create(value: "Suppositories")
	MedicationType.create(value: "Drops")
	MedicationType.create(value: "Inhalers")
	MedicationType.create(value: "Injections")
	MedicationType.create(value: "Implants ")
	MedicationType.create(value: "Patches")
	MedicationType.create(value: "Pill")
	MedicationType.create(value: "Vitamin")

#Medications

Medication.create(:name => "Vicodion" , :description => "Powerfull painkiller")
Medication.create(:name => "Acetaminofen" , :description => "Anti-Flu medicine")
Medication.create(:name => "Malox" , :description => "Medicine for stomach-ache")
Medication.create(:name => "Insuline" , :description => "Health supplement against diabetus")
Medication.create(:name => "Cortisol" , :description => "Awesome does it all medicine")
Medication.create(:name => "Peniciline" , :description => "Fungus based medicine against deseases")
Medication.create(:name => "Festal" , :description => "Digestive")

# UNITS

	Unit.create(value: "Unit")
	Unit.create(value: "Grams")
	Unit.create(value: "Half Unit")
	Unit.create(value: "One and Half Unit")
	Unit.create(value: "Miligrams")
	Unit.create(value: "Teaspoon")
	Unit.create(value: "Mililiters")


#treatments

9.times do |i|
	Treatment.create(
					start: DateTime.now.to_date ,
					finish: DateTime.now.midnight, 
					hour: 10.minutes.ago.strftime("%I:%m %p"),
					frequency_quantity: 1,
					frequency_id: Frequency.last.id,
					user_id: User.first.id,
					medication_id: Medication.first.id,
					unit_id: Unit.first.id,
					medication_type_id: MedicationType.last.id
				)
 end
