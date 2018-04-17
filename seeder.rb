require "./config/environment.rb"

def parse_from_api(link)
    all_characters = RestClient.get(link)
    character_hash = JSON.parse(all_characters)
end
  
def get_character_movies_from_api(character)
    character_hash = parse_from_api('http://www.swapi.co/api/people/')

    films_array = character_hash["results"].map do |character_info|
        if character == character_info["name"]
            character_info["films"]
        end
    end
    return films_array.compact.flatten
end

