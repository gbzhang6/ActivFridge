class Fridge < ActiveRecord::Base
  has_many :items
  has_many :users, through: :items


  def self.set_fridge
    fridge_hash = Fridge.index_and_fridges
    puts "\n"
    input = Fridge.input_for_fridge
    fridge = fridge_hash[input]
  end

  def self.index_and_fridges
    "Please enter the number of the fridge you want to open" + "\n"
    fridge_hash = {}
    Fridge.all.map.with_index(1) do |fridge, index|
      fridge_hash["#{index}"] = fridge
      puts "#{index}. #{fridge.name}"
    end.compact
    fridge_hash
  end

  def self.input_for_fridge
    input = Console.prompt.ask("Enter Number:", default: ENV['USER'])
    if input.to_i.class != Integer
      puts "Stop trolling around, bub."
      Fridge.input_for_fridge
    end
    input
  end

  def self.see_my_items(user)
    puts "\n"
    fridge = Fridge.set_fridge
    Fridge.select_my_fridge(fridge, user)
  end

  def self.select_my_fridge(fridge, user)
    puts "You have selected " + Console.pastel.yellow("#{fridge.name}") + "\n"

    puts "Your items in this fridge:" 
    puts "\n"
    all_items = fridge.items.where(user_id: user.id).map{|item| puts Console.pastel.green("#{User.find(item.user_id).name}") +"'s #{item.name}"}
    all_items.sort
    puts "\n"

    Console.fridge_menu
    puts "\n"
  end

  def self.view_all_fridges
    fridge = Fridge.set_fridge
    Fridge.all_items_in_a_fridge(fridge)
  end
  def self.all_items_in_a_fridge(fridge)
    puts "You have selected " + Console.pastel.yellow("#{fridge.name}")
    puts "\n"
    puts "Items in this fridge:"
    fridge.items.order(:id)
    all_items = fridge.items.map do |item|
      puts Console.pastel.green("#{User.find(item.user_id).name}") +"'s #{item.name}"
    end

    puts "\n"
    Console.fridge_menu
    puts "\n"
  end

  def self.see_users_in_fridge
    puts "\n"
    fridge = Fridge.set_fridge
    Fridge.list_people_in_fridge(fridge)
  end

  def self.list_people_in_fridge(fridge)
    puts "You have selected " + Console.pastel.yellow("#{fridge.name}") + "\n"

    user_ids = fridge.items.map{|item| item.user_id}.uniq
    user_ids.map{|id| puts "#{User.find(id).name}"}
    puts "\n"
    Console.fridge_menu
    puts "\n"
  end

  def self.add_to_fridge(user)
    fridge = Fridge.set_fridge
    puts "\n"
    Fridge.set_item_fridge_id(fridge, user)
  end

  def self.set_item_fridge_id(fridge, user)
    if fridge.id.nil?
      user.items.map do |item|
        item.update_attribute(:fridge_id, fridge.id)
        puts "* #{item.name}"
      end.compact
    else
      user.items.last.update_attribute(:fridge_id, fridge.id)
    end
    puts "\n"
    puts "Your Item(s) was put into the " + Console.pastel.yellow("#{fridge.name}") + "."
    puts "\n"
  end

  def self.clear_fridge
    answer = Console.prompt.yes?(Console.pastel.bright_red.bold("WARNING: ") + Console.pastel.yellow("The fridge you select will have ALL items deleted:"))
    if answer 
      fridge = Fridge.set_fridge
      round2 = Console.prompt.yes?(Console.pastel.bright_red.bold("WARNING: ") + Console.pastel.yellow("This will delete ALL items in this fridge"))
      if round2 == true
        fridge.items.each{|i| i.destroy}
        puts "Spring cleaning! All items in" + Console.pastel.green("#{fridge.name}") + "have been purged."
      else puts Console.pastel.yellow("You have opted to") + Console.pastel.yellow.bold(" NOT ") + Console.pastel.yellow("delete any items.")
      end
    else 
      puts Console.pastel.yellow("You have opted to") + Console.pastel.yellow.bold(" NOT ") + Console.pastel.yellow("delete any items.")
    end

    puts "\n"
    Console.fridge_menu
    puts "\n"
  end

  def self.create_new_fridge
    input = Console.prompt.ask("Enter a name for this Fridge:", default: ENV['USER'])
    if input.class != String
      puts "Stop trolling around, bub."
      Fridge.create_new_fridge
    end
    Fridge.create(name: input, status: nil)
    puts "\n"
    puts "Congratulations! You can now put stuff in " + Console.pastel.yellow("#{input}") + "."
    puts "\n"
    Console.fridge_menu
    puts "\n"
  end
end
