require_relative '../config/environment'

class Console < ActiveRecord::Base
  attr_accessor :logged_user

  def self.prompt
    TTY::Prompt.new
  end

  def self.font
    TTY::Font.new(:starwars)
  end

  def self.pastel
    Pastel.new
  end

  def self.title
    puts "\n"
    puts Console.pastel.bright_white.bold(Console.font.write(" ACTIV    FRIDGE "))
    puts Console.pastel.white("  by MyungZhang")
    puts "\n"
  end

  def self.welcome
    user_name = Console.prompt.ask("Please enter your name:", default: ENV['USER'])
    Console.validate_or_create_user(user_name)
  end

  def self.validate_or_create_user(user_name)
    if !user_name.include?(" ")
      puts "Invalid user or name. Please enter your first and last name."
      puts "\n"
      # self.welcome
    elsif User.where(name: user_name).exists?
      @logged_user = User.where(name: user_name)[0]
      puts "Welcome back " + Console.pastel.green("#{user_name}!") + " status: " + Console.pastel.green("#{@logged_user.status}!")
      puts "\n"
    else
      new_user = User.create(name: user_name, status: "", pantry: "empty")
      @logged_user = new_user
      basket = Item.welcome_basket(new_user.id)
      puts "\n"
      puts "Welcome to " + Console.pastel.yellow.bold("ActivFridge") + Console.pastel.green(" #{user_name}")
      puts "We've prepared a welcome basket for you!"
      puts "\n"
      puts "Please enter the number of the fridge you want to store your item(s) in"

      Fridge.add_to_fridge(@logged_user)
      #Console.select_fridge_and_add
    end
    Console.main_menu
  end

  def self.main_menu
    Console.prompt.select("What would you like to do?") do |menu|
        menu.choice "Fridge Menu", -> {Console.fridge_menu}
        menu.choice "Item Menu", -> {Console.item_menu}
        menu.choice Console.pastel.red("Leave"), -> {puts 'Bye!'}
    end
  end

  def self.fridge_menu
    Console.prompt.select("Fridge Menu:") do |menu|
      menu.choice "Open a Fridge", -> {Fridge.view_all_fridges}
      menu.choice "See my Items in Fridge", -> {Fridge.see_my_items(@logged_user)}
      menu.choice "See Users in Fridge", -> {Fridge.see_users_in_fridge}
      menu.choice "Add a New Fridge", -> {Fridge.create_new_fridge}
      menu.choice "Clear out a Fridge", -> {Fridge.clear_fridge}
      menu.choice Console.pastel.yellow("Back to Main Menu"), -> {Console.main_menu}
    end
  end

  def self.item_menu
    Console.prompt.select("Item Menu:") do |menu|
      menu.choice "View All Items", -> {Item.view_all_items}
      menu.choice "View Your Items", -> {Item.view_my_items(@logged_user)}
      menu.choice "Move Item to Another Fridge", -> {Item.move_to_different_fridge(@logged_user)}
      menu.choice "Find Item", -> {Item.find_item}
      menu.choice "New Item", -> {Item.new_item(@logged_user)}
      menu.choice "Delete Item", -> {puts "bye old"}
      menu.choice Console.pastel.yellow("Back to Main Menu"), -> {Console.main_menu}
    end
  end
end

def run
  console = Console.new
  Console.title
  Console.welcome
  Console.main_menu
end

#system("clear")
run

#puts "Welcome, #{current_user.name}!"
# Console.prompt.select("Are you a new or an existing user?") do |menu|
#   menu.choice "New User", @logged_user = (Console.create_user(user_name))
#   menu.choice "Returning User",  @logged_user = (Console.find_user(user_name))
# end
#
# puts "Welcome #{@logged_user.name}"
