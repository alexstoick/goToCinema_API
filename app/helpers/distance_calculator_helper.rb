module DistanceCalculatorHelper

	def rad(x)
		return x*Math::PI/180;
	end

	def calcDist (p1, p2)
		r = 6371; # earth's mean radius in km
		dLat  = rad(p2["lat"] - p1["lat"])
		dLng = rad(p2["lng"] - p1["lng"])

		a = Math.sin(dLat/2) * Math.sin(dLat/2) +
		      Math.cos(rad(p1["lat"])) * Math.cos(rad(p2["lat"])) * Math.sin(dLng/2) * Math.sin(dLng/2)
		c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
		d = r * c;

		return ((d.round(1))/10).round(1)
	end


end
