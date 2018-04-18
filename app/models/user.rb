class User < ActiveRecord::Base
    has_many :items
    has_many :fridges, through: :items
 end
