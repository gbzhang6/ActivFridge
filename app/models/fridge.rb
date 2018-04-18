class Fridge < ActiveRecord::Base
   has_many :items
   has_many :users, through: :items

   def fridge_items(fridge_id)
     Item.where(fridge_id: fridge_id)
   end

end
