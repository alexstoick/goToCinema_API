class MoviesController < ApplicationController
  # GET /movies
  # GET /movies.json
  def index
    @movies = Movie.all

    json= []

    @movies.each do |movie|
    	movie.showtimes.each do |showtime|
    		json.push ( {
    					"id" 		=> movie.id 	,
    					"titluRo"	=> movie.titluRo,
    					"titluEn"	=> movie.titluEn,
    					"regizor"	=> movie.regizor,
    					"actori"	=> movie.actori	,
    					"nota"		=> movie.nota	,
    					"gen"		=> movie.gen	,
    					"image"		=> movie.image	,
    					"ora"		=> showtime.hour,
    					"cinema"	=> showtime.place } )

    	end
    end
	render json: json
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
    movie = Movie.find(params[:id])
    render json: movie
  end

  def aparitii
  	movie = Movie.find(params[:id])
  	render json: movie.showtimes.select( "hour, place" )
  end

end
