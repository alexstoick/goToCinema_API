# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create! ( :email=>'mail@google.com' , :name=>'Vlad' , :password=>'vladpass' )
User.create ( email:'mail@google.com' ) #, name:'Vlad' , password:'vladpass' )
#Movie.create ( titluEn:'al titluEn' , titluRo: 'alt titlu Ro' , nota:'100432' , regizor:'regie epica',
#				actori:'za best', gen: 'gen cel mai smecher' )