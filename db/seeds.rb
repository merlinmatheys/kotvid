# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Kot.destroy_all
User.destroy_all


User.create!(
  {
    email: 'user@user.com',
    password: '123456',
    name: 'Merlin',
 })

Kot.create!(
  {
    addresse: 'Rue de la Citronnelle 07/000 - 1348 Louvain-la-Neuve',
    type_kot: 'Kot UCL',
    quartier: 'Biéreau',
    nombre_chambres: 4,
    user_id: 1
 })
