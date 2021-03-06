# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

FactoryGirl.reload

Book.destroy_all
Category.destroy_all
CategoryBook.destroy_all
FactoryGirl.create_list :book, 20
FactoryGirl.create_list :category, 5

Book.find_each do |book|
  Category.find_each do |category|
    category.books << book if rand > 0.5
  end
end
