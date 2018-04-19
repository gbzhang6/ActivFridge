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
    puts Console.pastel.bright_white.bold(Console.font.write("ACTIV    FRIDGE"))
    puts "\n"
  end

  def self.welcome
    user_name = Console.prompt.ask("Please enter your name:", default: ENV['USER'])
    Console.validate_or_create_user(user_name)
  end

  def self.validate_or_create_user(user_name)
    if !user_name.include?(" ")
      puts "Invalid user, please enter your first and last name."
      self.welcome
    elsif User.where(name: user_name).exists?
      @logged_user = User.where(name: user_name)
      puts "Welcome back #{user_name}! Which fridge would you like to access by number?"
    else
      new_user = User.create(name: user_name, status: "", pantry: "empty")
      @logged_user = new_user
      basket = Item.welcome_basket(new_user.id)
      puts "Welcome to ActivFridge #{user_name}! We are providing you with a welcome basket, please enter the number of the fridge would you like put it into?"
    end

  end

  def self.find_and_display_fridges
    if @logged_user[0].items[0].fridge_id.nil?
      puts Fridge.display_all_fridge_with_index
      self.add_item_to_fridge
    else
      puts Fridge.user_fridges_with_index
    end
  end

  def self.add_item_to_fridge
    input = gets.chomp
  end

end

def run
  console = Console.new
  Console.title
  Console.welcome
  Console.find_and_display_fridges
  Console.add_item_to_fridge

end

run

#puts "Welcome, #{current_user.name}!"
# Console.prompt.select("Are you a new or an existing user?") do |menu|
#   menu.choice "New User", @logged_user = (Console.create_user(user_name))
#   menu.choice "Returning User",  @logged_user = (Console.find_user(user_name))
# end
#
# puts "Welcome #{@logged_user.name}"
