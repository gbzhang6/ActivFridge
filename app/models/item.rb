class Item < ActiveRecord::Base
    belongs_to :users  
    belongs_to :fridges
 end