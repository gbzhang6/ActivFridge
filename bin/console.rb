require_relative '../config/environment'
prompt = TTY::Prompt.new
font = TTY::Font.new(:doom)
pastel = Pastel.new

puts "\n"
puts pastel.bright_white.bold(font.write("ACTIV    FRIDGE"))
puts "\n"
name = prompt.ask("Please enter your name:", default: ENV['USER'])
current_user = User.find_or_create_by(name: name, status: "happy", pantry: "empty")



#puts "Welcome, #{current_user.name}!"