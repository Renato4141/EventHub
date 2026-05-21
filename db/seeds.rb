
Venue.destroy_all
EventCategory.destroy_all
Registration.destroy_all
Review.destroy_all
Event.destroy_all
Category.destroy_all
User.destroy_all

# USERS
alice = User.create!(name: "Alice Martínez", email: "alice@test.com", password: "123456", role: :organizer)
bob   = User.create!(name: "Bob Torres",     email: "bob@test.com",   password: "123456", role: :attendee)
carol = User.create!(name: "Carol Núñez",    email: "carol@test.com", password: "123456", role: :attendee)
david = User.create!(name: "David Lagos",    email: "david@test.com", password: "123456", role: :organizer)
eva   = User.create!(name: "Eva Ríos",       email: "eva@test.com",   password: "123456", role: :attendee)

# CATEGORIES
tech   = Category.create!(name: "Technology")
music  = Category.create!(name: "Music")
sports = Category.create!(name: "Sports")
food   = Category.create!(name: "Food & Drinks")
art    = Category.create!(name: "Art")

# VENUES
centro = Venue.create!(name: "Centro Cultural GAM", address: "Av. O'Higgins 227, Santiago", capacity: 500)
teatro = Venue.create!(name: "Teatro Caupolicán",   address: "San Diego 850, Santiago",     capacity: 3000)
riesco = Venue.create!(name: "Espacio Riesco",      address: "El Salto 5000, Santiago",     capacity: 1000)
parque = Venue.create!(name: "Parque Bicentenario", address: "Av. Bicentenario, Vitacura",  capacity: 5000)
puerto = Venue.create!(name: "Espacio Puerto",      address: "Errázuriz 785, Valparaíso",   capacity: 200)

# EVENTS - finished (past)
rails_conf = Event.create!(
  name: "Rails Conference 2025",
  description: "Annual Ruby on Rails conference with talks and workshops.",
  date: DateTime.now - 60,
  location: "Santiago",
  capacity: 100,
  status: :finished,
  user: alice,
  venue: riesco
)

jazz_night = Event.create!(
  name: "Jazz Night",
  description: "Live jazz music with local artists.",
  date: DateTime.now - 30,
  location: "Valparaíso",
  capacity: 80,
  status: :finished,
  user: bob,
  venue: puerto
)

# EVENTS - published (upcoming)
hackathon = Event.create!(
  name: "Hackathon 2026",
  description: "48-hour hackathon open to all developers.",
  date: DateTime.now + 15,
  location: "Santiago",
  capacity: 2,
  status: :published,
  user: alice,
  venue: centro
)

food_festival = Event.create!(
  name: "Food Festival",
  description: "Taste the best local food and drinks.",
  date: DateTime.now + 30,
  location: "Concepción",
  capacity: 300,
  status: :published,
  user: carol,
  venue: parque
)

marathon = Event.create!(
  name: "City Marathon",
  description: "Annual city marathon open to all runners.",
  date: DateTime.now + 45,
  location: "Santiago",
  capacity: 500,
  status: :published,
  user: david,
  venue: parque
)

# EVENTS - draft
art_expo = Event.create!(
  name: "Art Expo 2026",
  description: "Contemporary art exhibition by local artists.",
  date: DateTime.now + 90,
  location: "Viña del Mar",
  capacity: 150,
  status: :draft,
  user: eva,
  venue: teatro
)

# EVENT CATEGORIES
EventCategory.create!(event: rails_conf,    category: tech)
EventCategory.create!(event: jazz_night,    category: music)
EventCategory.create!(event: hackathon,     category: tech)
EventCategory.create!(event: food_festival, category: food)
EventCategory.create!(event: marathon,      category: sports)
EventCategory.create!(event: art_expo,      category: art)
EventCategory.create!(event: hackathon,     category: art)

# REGISTRATIONS
Registration.create!(user: bob,   event: rails_conf,    status: :confirmed)
Registration.create!(user: carol, event: rails_conf,    status: :confirmed)
Registration.create!(user: david, event: rails_conf,    status: :cancelled)
Registration.create!(user: alice, event: jazz_night,    status: :confirmed)
Registration.create!(user: eva,   event: jazz_night,    status: :confirmed)
Registration.create!(user: bob,   event: hackathon,     status: :confirmed)
Registration.create!(user: carol, event: hackathon,     status: :confirmed)
Registration.create!(user: eva,   event: hackathon,     status: :waitlisted)
Registration.create!(user: david, event: hackathon,     status: :waitlisted)
Registration.create!(user: alice, event: food_festival, status: :confirmed)
Registration.create!(user: bob,   event: food_festival, status: :pending)
Registration.create!(user: carol, event: marathon,      status: :confirmed)
Registration.create!(user: david, event: marathon,      status: :confirmed)
Registration.create!(user: eva,   event: marathon,      status: :pending)

# REVIEWS (solo en eventos finished)
Review.create!(user: bob,   event: rails_conf, rating: 5, comment: "Excellent talks, very well organized.")
Review.create!(user: carol, event: rails_conf, rating: 4, comment: "Great content but the venue was a bit small.")
Review.create!(user: alice, event: jazz_night, rating: 5, comment: "Incredible atmosphere and great musicians.")
Review.create!(user: eva,   event: jazz_night, rating: 4, comment: "Loved the music, would come back next year.")

puts "Seeded: #{User.count} users, #{Venue.count} venues, #{Event.count} events, #{Category.count} categories"
puts "        #{Registration.count} registrations, #{Review.count} reviews"