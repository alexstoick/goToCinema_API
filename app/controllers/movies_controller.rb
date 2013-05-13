class MoviesController < ApplicationController

  def index
    movies = Movie.all

    json= []

  	render json: movies.to_json( :only => [ :id , :actori , :gen , :image , :nota , :regizor , :titluEn , :titluRo] ,
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
