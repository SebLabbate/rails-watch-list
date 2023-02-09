# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'open-uri'

api = '246c25583f1579de9a8d2f1825bd140d'

res = URI.open("https://api.themoviedb.org/3/movie/popular?api_key=#{api}&language=en-US&page=1").read
data = JSON.parse(res)

data['results'].first(10).each do |result|
  Movie.create!(
    title: result['title'],
    overview: result['overview'],
    poster_url: "https://image.tmdb.org/t/p/w500/#{result['poster_path']}",
    rating: result['vote_average']
  )
end
