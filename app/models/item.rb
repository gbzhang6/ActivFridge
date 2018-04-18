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


 end
