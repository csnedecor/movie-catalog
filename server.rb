require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'CSV'

def movies_array
  movies= File.readlines('movies.csv')
  movies_array = []
  movies.each do |movie|
    movies_array << movie.split(',')
  end
  movies_array
end




get '/' do
  erb :home
end

get '/movies' do
  @movies_array = movies_array
  erb :movies
end

get 'movies/:movie_id' do
  params[:movie_id]
  erb :show
end
