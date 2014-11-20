require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'CSV'

def movies_array
  movies_array = []
  CSV.foreach('movies.csv', headers:true) { |movie| movies_array << Hash[movie] }
  movies_array
end

get '/' do
  erb :home
  redirect '/movies'
end

get '/movies' do
  @movies_array = movies_array.sort_by {|movie| movie['title']}
  erb :movies
end

get '/movies/:movie_id' do
  movies_array.each do |movie|
    if movie['id'] == params[:movie_id]
      @movie = movie
    end
  end
  erb :show
end
