class MoviesController < ApplicationController

  def index
    movies = Movie.includes ( :showtimes )

    json= []

  	render json: movies.to_json( :except => [ :created_at , :updated_at ] ,# , :actori , :gen , :image , :nota , :regizor , :titluEn , :titluRo] ,
  					:include => { :showtimes => { :only => [ :hour , :place ] } } )

  end

  def show
    movie = Movie.find(params[:id])
    render json: movie
  end

  def aparitii
  	movie = Movie.find(params[:id])

  	render json: movie.to_json( :only => [ :actori , :gen , :image , :nota , :regizor , :titluEn , :titluRo] ,
  					:include => { :showtimes => { :only => [ :hour , :place ] } } )

  end

end
