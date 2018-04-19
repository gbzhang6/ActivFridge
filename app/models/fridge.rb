class Fridge < ActiveRecord::Base
   has_many :items
   has_many :users, through: :items

   def self.display_all_fridge_with_index
     fridge_hash = {}
     Fridge.all.map.with_index(1) do |fridge, index|
       fridge_hash["#{index}"] = fridge
       puts "#{index}. #{fridge.name}"
     end.compact
   end

   # # Console.prompt.select("Which fridge would you like to access by number") do |menu|
   # #   menu.choice "Flatiron", @logged_user = (Console.create_user(user_name))
   # #   menu.choice "Returning User",  @logged_user = (Console.find_user(user_name))
   # end

   def self.user_fridges_with_index
   end

end
