require 'sinatra'
require 'pry'
require 'CSV'
require 'sinatra/reloader'

def movies_array
  movies_array = []
  CSV.foreach('movies.csv', headers:true) { |movie| movies_array << Hash[movie] }
  movies_array
end

def show_movies
  @show = []
  if params.key?('query')
    movies_array.each do |movie|
      if movie['synopsis'] == nil || movie['synopsis'] == ''
        @show
      elsif movie['synopsis'].downcase.include?(params['query'].downcase)
          @show << movie
      end
      if movie['title'].downcase.include?(params['query'].downcase)
        @show << movie
      end
      @show = @show.sort_by {|movie| movie['title']}
    end
  else
    @show = movies_array.sort_by {|movie| movie['title']}
  end
end

get '/' do
  redirect '/movies'
end

get '/movies' do
  show_movies
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
