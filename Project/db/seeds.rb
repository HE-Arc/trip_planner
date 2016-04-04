# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


userTest = User.create( :email => "guy@gmail.com", :password => "1234", :password_confirmation => "1234")

Trip.create(title:"Voyage au Japon de Mama", description:"Margaux part en voyage", date_start:"2015-10-10", date_end:"2015-10-12", main_country:"Japan", user: userTest)
Trip.create(title:"Le pays des licornes", description:"Afin de découvrir cette race méconnue", main_country:"DiscoveryLand", user: userTest)

Stagetype.create(title:"Restauration", icon:"fa-cutlery")
Stagetype.create(title:"Hôtel", icon:"fa-bed")
Stagetype.create(title:"Visite", icon:"fa-fort-awesome")
Stagetype.create(title:"Shopping", icon:"fa-shopping-cart")
Stagetype.create(title:"Partage", icon:"fa-users")
