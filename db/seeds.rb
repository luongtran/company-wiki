# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Permision.create([{:title => 'view', :active => true}, {:title => 'create', :active => true}, {:title => 'update', :active => true}, 
                  {:title => "destroy", :active => true}])
