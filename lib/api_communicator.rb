require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character, page_num = 1)
  #make the web request
  new_page_num = page_num

  first_page = RestClient.get('http://www.swapi.co/api/people/?page=' + page_num.to_s)
  first_page_hash = JSON.parse(first_page)

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.

  first_page_hash["results"].each do |object|
    if object["name"].downcase == character
      p "#{object["name"]} FOUND"
      return get_films_from_api(object["films"])
    end
  end

  if first_page_hash["next"]
    new_page_num += 1
    p "next page"
    get_character_movies_from_api(character, new_page_num)
  else
    p "CHARACTER NOT IN DATABASE"
  end

end

def get_films_from_api(url_film_array)
  film_array = []

  url_film_array.each do |url|
    all_films = RestClient.get(url)
    film_hash = JSON.parse(all_films)
    film_array << film_hash
  end
  parse_character_movies(film_array)
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  p "~~~Move Titles~~~"
  films_hash.select do |film|

    p film["title"]
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
