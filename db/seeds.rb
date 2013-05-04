# encoding utf-8
require 'nokogiri'
require 'open-uri'
require 'json'

page = Nokogiri::HTML(open('http://www.cinemagia.ro/program-cinema/bucuresti/'))

json = []

Movie.delete_all

puts page.css(".program_cinema_show").length

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
			for i in 0..length
				ora = program[i*5 , 5 ]
				intrare = {}
				intrare [ "titluEn" ] = titluEn
				intrare [ "titluRo" ] = titluRo
				intrare [ "cinema" ] = cinemaName
				intrare [ "ora" ] = ora ;
				intrare [ "nota" ] = nota ;
				intrare [ "gen" ] = gen ;
				intrare [ "actori" ] = actori ;
				intrare [ "regizor" ] = regizor ;
				Movie.create ( intrare )
				json.push ( intrare )
			end
		end
	end
end