# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Admin.create(username:'admin', email:"mammothadmin@gmail.com", password:'admin1234', password_confirmation:"admin1234")
User.create(username:"user1", email:"kiplangatisack.is@gmail.com", password:"1234",password_confirmation:"1234")
