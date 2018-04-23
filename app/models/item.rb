require 'faker'

class Item < ActiveRecord::Base
  belongs_to :users
  belongs_to :fridges

  def self.input_for_item
    input = Console.prompt.ask("Enter an Item:", default: ENV['USER'])
    # if input.to_s.class != String
    #   puts "Stop trolling around, bub."
    #   Item.input_for_item
    # end
    #input
  end

  def self.view_all_items
    puts "#{Item.all.order(:name).map{|i|i.name}.uniq}"

    puts "\n"
    Console.item_menu
  end

  def self.view_my_items(user)
    puts "#{Item.all.where(user_id: user.id).map{|i|i.name}.uniq}"

    puts "\n"
    Console.item_menu
  end

  def self.find_item
    puts "\n"
    puts "Please enter the name of the Item you are searching for:"
    puts "\n"
    input = Item.input_for_item
    item_arr = Item.where(name: input)
    if item_arr.empty?
      puts "Sorry, we couldn't find an Item that matches " + Console.pastel.yellow("#{input}") + ". This Item might not be in any Fridge. Please check your input and try again."
    else
      item_arr.map do |item|
        puts "\n"
        puts Console.pastel.green("#{item.name}") + " is in " + Console.pastel.yellow("#{Fridge.find(item.fridge_id).name}") + "."
      end
    end
    puts "\n"
    Console.item_menu
  end

  def self.new_item(user)
    puts "\n"
    puts "What is the name of this Item?"
    puts "\n"
    name = Item.input_for_item
    item = Item.create(name: name, quantity: 1, expiration_date: Faker::Date.between(15.days.ago, 30.days.from_now), user_id: user.id, fridge_id: nil)
    puts "Which Fridge do you want to add this to?"
    puts "\n"
    Fridge.add_to_fridge(user)
    puts "\n"
    Console.item_menu
  end

  def self.move_to_different_fridge(user)
    Item.find_item_to_move_to_different_fridge(user)

    puts "\n"
    Console.item_menu
    puts "\n"
  end

  def self.find_item_to_move_to_different_fridge(user)
    puts "\n"
    puts "Please enter the name of the Item you want to move:"
    input = Item.input_for_item
    item_arr = Item.where(name: input)
    if item_arr.empty?
      puts "Sorry, we couldn't find an Item that matches " + Console.pastel.yellow("#{input}") + ". This Item might not be in any Fridge. Please check your input and try again."
    elsif user.items.select{|item| item.name == input}.empty?
      puts "\n"
      puts Console.pastel.bright_red.bold("You do not own any of this item. You have been caught trying to steal food. From now on, the system will recognize you as a MOOCH.")
      puts "\n"
      user.update_attribute(:status, Console.pastel.bright_red.bold(user.status = "MOOCH"))
      puts Console.pastel.green("#{user.name}") + " status: " "#{user.status}"
      puts "\n"

      Console.main_menu
    else
      puts "\n"
      puts "Select the Item you would like to take:"
      puts "\n"
      search_results_hash = Item.display_search_results_for_move_to_different_fridge(item_arr)
      puts "\n"
      puts "Select the Fridge you want to move this into."
      puts "\n"
      search_results_hash_key = Item.input_for_item
      item = search_results_hash[search_results_hash_key]
      #might pry this
      Item.verify_user_for_move_to_different_fridge(user, item)
    end
  end

  def self.display_search_results_for_move_to_different_fridge(item_arr)
    item_hash = {}
    item_arr.map.with_index(1) do |item, index|
      item_hash["#{index}"] = item
      puts "#{index}. " + Console.pastel.green("#{item.name}") + " in " + Console.pastel.yellow("#{Fridge.find(item.fridge_id).name}")
    end.compact
    item_hash
  end

  def self.verify_user_for_move_to_different_fridge(user, item)
    if user.id != item.user_id
      puts "\n"
      puts Console.pastel.bright_red.bold("You have been caught trying to steal food. From now on, the system will recognize you as a MOOCH.")
      puts "\n"
      user.update_attribute(:status, Console.pastel.bright_red.bold(user.status = "MOOCH"))
      puts Console.pastel.green("#{user.name}") + " status: " "#{user.status}"
      puts "\n"
    else
      Fridge.add_to_fridge(user)
    end
  end

  # def get_all_instances_by_name(name)
  #   Item.where(name: name)
  # end

  # def find_users_who_own_item(name)
  #     items = get_all_instances_by_name(name)
  #     items.map{|i| User.find_by_id(i.user_id)}
  # end

  # def find_fridges_who_with_item(name)
  #   items = get_all_instances_by_name(name)
  #   items.map{|i| Fridge.find_by_id(i.fridge_id)}
  # end

  def self.welcome_basket(id)
    8.times{Item.create(name: Faker::Food.ingredient, quantity: rand(1..10), expiration_date: Faker::Date.forward(30), user_id: id, fridge_id: nil)}
  end

end
