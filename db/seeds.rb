# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Seeding the database..."

CHARACTERS  = 100
QUOTES      = 400

if Characters.count < CHARACTERS
  n = Characters - Character.count
  puts "Creating #{n} characters..."
  n.times do
    Character.create(name: Faker::Superhero.name)
  end
end

if Quotes.count < QUOTES
  n = QUOTES - Quote.count
  puts "Creating #{n} quotes..."
  n.times do
    Publisher.create(name: Faker::Hipster.paragraph)
  end
end
