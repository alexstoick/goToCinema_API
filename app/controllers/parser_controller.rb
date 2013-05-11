class ParserController < ApplicationController
	def index

		require 'nokogiri'
		require 'open-uri'
		require 'json'

		if ( Movie.count == 0 )
			time_difference = 61*60
		else
			time_difference = Time.now - Movie.first.updated_at
		end

		puts time_difference
		time_difference = 61
		if time_difference < 60
			redirect_to :action => "early_reload"
		else
			page = Nokogiri::HTML(open('http://www.cinemagia.ro/program-cinema/bucuresti/'))
			json = []
			Movie.delete_all
			Showtime.delete_all
			movies = page.css(".program_cinema_show")
			movie_ids = 0
			showtime_ids = 0
			for k in 0..(movies.length-1) do
				film = movies[k]

				img = film.css("img")[0]["src"]
				titluRo = film.css(".title_ro").text
				titluEn = film.css("h2:first").text
				details = film.css(".info")[0]

				if ( details.css("div").length < 4 )
					next
				end

				nota = details.css("div")[0].text
				gen = details.css("div")[1].text
				actori = details.css("div")[2].text
				regizor = details.css("div")[3].text

				gen = gen.gsub( /\s\s+/ , '' )
				actori = actori.gsub( /\s\s+/ , '' )
				regizor = regizor.gsub( /\s\s+/ , '' )

				movie_ids = movie_ids + 1
				intrare = Movie.new
				intrare.id = movie_ids
				intrare.titluEn = titluEn
				intrare.titluRo = titluRo
				intrare.nota = nota ;
				intrare.gen = gen ;
				intrare.actori = actori ;
				intrare.regizor = regizor ;
				intrare.image = img
				intrare.save!

				cinematografe = film.css(".theatre-link")#.css("div")

				cinematografe.each do |cinematograf|
					cinemaName = cinematograf.text
					cinemaName = cinemaName.gsub(/[^0-9a-zA-Z :]/, '' )
					length = cinematograf.parent.css("div").length
					length1 = cinematograf.parent.parent.css("div").length
					case length
						when 0
							program = cinematograf.parent.parent.css("div")[1].text
						when 1
							program = cinematograf.parent.css("div")[0].text
					end

					program = program.gsub(/[^0-9:]/, '')
					length = (program.length)/5-1

					for i in 0..length do

						ora = program[i*5 , 5 ]
						showtime_ids += 1
						showtime = Showtime.new
						showtime.id = showtime_ids
						showtime.place = cinemaName
						showtime.hour = ora
						showtime.movie_id = movie_ids
						showtime.save!

						intrare = {}
						intrare [ "image"] = img
						intrare [ "titluEn" ] = titluEn
						intrare [ "titluRo" ] = titluRo
						intrare [ "cinema" ] = cinemaName
						intrare [ "ora" ] = ora ;
						intrare [ "nota" ] = nota ;
						intrare [ "gen" ] = gen ;
						intrare [ "actori" ] = actori ;
						intrare [ "regizor" ] = regizor ;
						json.push ( intrare )
					end
				end
			end


			completeJSON = {}
			completeJSON["movies"] = json
			completeJSON["updated"] = Time.now.to_s

			generatedJSON = JSON.generate( completeJSON )

			#File.open( 'date.json', 'w' ) { |file| file.write( generatedJSON ) }

			render :text => "Successfully updated" + Time.now.to_s
		end
	end #index
	def early_reload
		render :text => "Not enough time since last reload of the data! "
	end
end
