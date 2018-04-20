require_relative "../config/environment.rb"
require 'pry'
# def parse_from_api(link)
#     all_characters = RestClient.get(link)
#     character_hash = JSON.parse(all_characters)
# end

# def get_character_movies_from_api(character)
#     character_hash = parse_from_api('http://www.swapi.co/api/people/')

#     films_array = character_hash["results"].map do |character_info|
#         if character == character_info["name"]
#             character_info["films"]
#         end
#     end
#     return films_array.compact.flatten
# end

User.create(name: "Mike Myung", status: "HUNGRY AF", pantry: "empty")
User.create(name: "Gui Zhang", status: "FATTY", pantry: "empty")

5.times{User.find_or_create_by(name: Faker::Name.first_name + " " + Faker::Name.last_name, status: "HAPPY", pantry: "empty")}

Fridge.create(name: "Flatiron Fridge", status: "dirty af")
Fridge.create(name: "Gui's Apartment Fridge", status: "empty af")
Fridge.create(name: "Kimchi Fridge", status: "stinky af")
Fridge.create(name: "Mike's family Fridge", status: "full af")
Fridge.create(name: "Mini Fridge", status: "beery af")

50.times{Item.create(name: Faker::Food.ingredient, quantity: rand(1..10), expiration_date: Faker::Date.between(15.days.ago, 30.days.from_now), user_id: rand(1..10), fridge_id: rand(1..5))}



# User.create(name: "ej", status: "happy", pantry: "empty")
# User.create(name: "paul", status: "happy", pantry: "empty")
# User.create(name: "gil", status: "happy", pantry: "empty")
# User.create(name: "bob", status: "happy", pantry: "empty")
# User.create(name: "humzah", status: "happy", pantry: "empty")
# User.create(name: "rishi", status: "mooch", pantry: "empty")
# User.create(name: "ryan", status: "happy", pantry: "empty")
# User.create(name: "jason", status: "mooch", pantry: "empty")

# Item.create(name: "turkey bacon", quantity: 2, expiration_date: 11/11/11, user_id: rand(1..10), fridge_id: rand(1..5))
# Item.create(name: "turkey bacon", quantity: 5, expiration_date: 11/15/15, user_id: rand(1..10), fridge_id: rand(1..5))
# Item.create(name: "yoghurt", quantity: 2, expiration_date: 10/12/12, user_id: rand(1..10), fridge_id: rand(1..5))
# Item.create(name: "eggs", quantity: 24, expiration_date: 12/12/12, user_id: rand(1..10), fridge_id: rand(1..5))
# Item.create(name: "eggs", quantity: 36, expiration_date: 12/12/12, user_id: rand(1..10), fridge_id: rand(1..5))
# Item.create(name: "eggs", quantity: 36, expiration_date: 12/12/12, user_id: rand(1..10), fridge_id: rand(1..5))
# Item.create(name: "eggs", quantity: 36, expiration_date: 12/12/12, user_id: rand(1..10), fridge_id: rand(1..5))
# Item.create(name: "eggs", quantity: 36, expiration_date: 12/12/12, user_id: rand(1..10), fridge_id: rand(1..5))
# Item.create(name: "pesto", quantity: 1, expiration_date: 11/15/99, user_id: rand(1..10), fridge_id: rand(1..5))
# Item.create(name: "pesto", quantity: 4, expiration_date: 11/15/99, user_id: rand(1..10), fridge_id: rand(1..5))
# Item.create(name: "provolone", quantity: rand(1..10), expiration_date: 11/15/99, user_id: rand(1..10), fridge_id: rand(1..5))
# Item.create(name: "prosciutto", quantity: rand(1..10), expiration_date: 11/15/99, user_id: rand(1..10), fridge_id: rand(1..5))
# Item.create(name: "almond milk", quantity: rand(1..10), expiration_date: 11/15/99, user_id: rand(1..10), fridge_id: rand(1..5))
# Item.create(name: "ezekiel bread", quantity: rand(1..10), expiration_date: 11/15/99, user_id: rand(1..10), fridge_id: rand(1..5))
# Item.create(name: "tomato", quantity: rand(1..10), expiration_date: 11/15/99, user_id: rand(1..10), fridge_id: rand(1..5))
# Item.create(name: "pesto", quantity: rand(1..10), expiration_date: 11/15/99, user_id: rand(1..10), fridge_id: rand(1..5))
# Item.create(name: "basil", quantity: rand(1..10), expiration_date: 11/15/99, user_id: rand(1..10), fridge_id: rand(1..5))
# Item.create(name: "mozzarella", quantity: rand(1..10), expiration_date: 11/15/99, user_id: rand(1..10), fridge_id: rand(1..5))
# Item.create(name: "chicken", quantity: rand(1..10), expiration_date: 11/15/99, user_id: rand(1..10), fridge_id: rand(1..5))
# Item.create(name: "beef flank", quantity: rand(1..10), expiration_date: 11/15/99, user_id: rand(1..10), fridge_id: rand(1..5))
# Item.create(name: "pomme de terre", quantity: rand(1..10), expiration_date: 11/15/99, user_id: rand(1..10), fridge_id: rand(1..5))
# Item.create(name: "pomme", quantity: rand(1..10), expiration_date: 11/15/99, user_id: rand(1..10), fridge_id: rand(1..5))
# Item.create(name: "onion", quantity: rand(1..10), expiration_date: 11/15/99, user_id: rand(1..10), fridge_id: rand(1..5))
# Item.create(name: "garlic", quantity: rand(1..10), expiration_date: 11/15/99, user_id: rand(1..10), fridge_id: rand(1..5))
# Item.create(name: "tomato", quantity: rand(1..10), expiration_date: 11/15/99, user_id: rand(1..10), fridge_id: rand(1..5))
# Item.create(name: "Haagen daz ice cream", quantity: rand(1..10), expiration_date: 11/15/99, user_id: rand(1..10), fridge_id: rand(1..5))
# Item.create(name: "frozen veg pork dumplings", quantity: rand(1..10), expiration_date: 11/15/99, user_id: rand(1..10), fridge_id: rand(1..5))
# Item.create(name: "kimchi", quantity: rand(1..10), expiration_date: 11/15/99, user_id: rand(1..10), fridge_id: rand(1..5))

# Pry.start
# true
