class User < ActiveRecord::Base
    has_many :fridges, through: :items
 end
