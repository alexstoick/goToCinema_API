class ParserController < ApplicationController
	def index

		require 'nokogiri'
		require 'open-uri'
		require 'json'

		if ( Movie.count == 0 )
			time_difference = 61
		else
			time_difference = Time.now - Movie.first.updated_at
		end

		if time_difference/60 < 60
			redirect_to :action => "early_reload"
		else

			page = Nokogiri::HTML(open('http://www.cinemagia.ro/program-cinema/bucuresti/'))

			json = []

			Movie.delete_all
			j = 0
			page.css(".program_cinema_show").each do |film|
				titluRo = film.css(".title_ro").text
				titluEn = film.css("h2:first").text
				details = film.css(".info")[0]

				nota = details.css("div")[0].text
				gen = details.css("div")[1].text
				actori = details.css("div")[2].text
				regizor = details.css("div")[3].text

				gen = gen.gsub( /\s\s+/ , '' )
				actori = actori.gsub( /\s\s+/ , '' )
				regizor = regizor.gsub( /\s\s+/ , '' )

				cinematografe = film.css(".mb5")

				cinematografe.each do |cinematograf|
					cinemaName = cinematograf.css(".theatre-link")[0].text
					length = cinematograf.css("div").length
					if length > 0

						program = cinematograf.css("div")[0].text

						program = program.gsub(/[^0-9:]/i, '')
						length = (program.length)/5-1
						for i in 0..length do
							ora = program[i*5 , 5 ]
							j = j + 1
							intrare = Movie.new
							intrare.id = j
							intrare.titluEn = titluEn
							intrare.titluRo = titluRo
							intrare.nota = nota ;
							intrare.gen = gen ;
							intrare.actori = actori ;
							intrare.regizor = regizor ;

							intrare.save!
							intrare = {}
							intrare [ "id" ] = j
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
			end

			completeJSON = {}
			completeJSON["movies"] = json
			completeJSON["updated"] = Time.now.to_s

			generatedJSON = JSON.generate( completeJSON )

			File.open( 'date.json', 'w' ) { |file| file.write( generatedJSON ) }
			render :text => "Successfully updated" + Time.now.to_s
		end
	end #index
	def early_reload
		render :text => "Not enough time since last reload of the data! "
	end
end
