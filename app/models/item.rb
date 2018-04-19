require 'faker'

class Item < ActiveRecord::Base
    belongs_to :users
    belongs_to :fridges

    def get_all_instances_by_name(name)
      Item.where(name: name)
    end

    def find_users_who_own_item(name)
        items = get_all_instances_by_name(name)
        items.map{|i| User.find_by_id(i.user_id)}
    end

    def find_fridges_who_with_item(name)
      items = get_all_instances_by_name(name)
      items.map{|i| Fridge.find_by_id(i.fridge_id)}
    end

    def self.welcome_basket(id)
      8.times{Item.create(name: Faker::Food.ingredient, quantity: rand(1..10), expiration_date: Faker::Date.forward(30), user_id: id, fridge_id: nil)}
    end

 end
