# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


userTest = User.create( :email => "guy@gmail.com", :password => "1234", :password_confirmation => "1234")

Trip.create(title:"Voyage au Japon de Mama", description:"Margaux part en voyage", user: userTest)
Trip.create(title:"Le pays des licornes", description:"Afin de découvrire cette race méconnue", user: userTest)

Stagetype.create(title:"Restauration", icon:"fa-cutlery")
Stagetype.create(title:"Hôtel", icon:"fa-bed")
Stagetype.create(title:"Visite", icon:"fa-fort-awesome")
Stagetype.create(title:"Shopping", icon:"fa-shopping-cart")
Stagetype.create(title:"Partage", icon:"fa-users")
