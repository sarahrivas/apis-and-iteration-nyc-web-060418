require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  count = 1

  first_page = RestClient.get('http://www.swapi.co/api/people/?page=' + count.to_s)
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

    until first_page_hash["next"] == nil

      first_page = RestClient.get('http://www.swapi.co/api/people/?page=' + count.to_s)
      first_page_hash = JSON.parse(first_page)

      first_page_hash["results"].each do |object|

        if object["name"].downcase == character
           get_films_from_api(first_page_hash["films"])
        
        else
          count += 1

        end
      end
    end

end

# def get_character_hash(character)
#
# end

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
  films_hash.each do |film|
    puts film["title"]
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
