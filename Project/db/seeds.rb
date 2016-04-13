# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Stagetype.create(title:"Restauration", icon:"fa-cutlery")
Stagetype.create(title:"Hôtel", icon:"fa-bed")
Stagetype.create(title:"Visite", icon:"fa-fort-awesome")
Stagetype.create(title:"Shopping", icon:"fa-shopping-cart")
Stagetype.create(title:"Partage", icon:"fa-users")
