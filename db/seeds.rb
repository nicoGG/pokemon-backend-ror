require 'rest-client'
require 'json'

POKEAPI_BASE_URL = 'https://pokeapi.co/api/v2/pokemon/'

Pokemon.destroy_all

def fetch_pokemon_data(id)
  response = RestClient.get("#{POKEAPI_BASE_URL}#{id}")
  JSON.parse(response.body)
rescue RestClient::ExceptionWithResponse => e
  puts "Error al obtener el Pokémon con ID #{id}: #{e.response}"
  nil
end

(1..150).each do |id|
  pokemon_data = fetch_pokemon_data(id)

  next if pokemon_data.nil?  

  name = pokemon_data['name']
  types = pokemon_data['types'].map { |type| type['type']['name'] }.join(', ')
  image = pokemon_data['sprites']['front_default']

  Pokemon.create!(
    name: name,
    types: types,
    image: image,
    captured: false,
    capture_date: nil
  )

  puts "Pokemon #{name} creado con éxito."
end

puts "Se han creado todos los Pokémon."

User.create!(username: 'admin', password: 'admin') unless User.exists?(username: 'admin')