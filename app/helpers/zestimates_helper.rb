module ZestimatesHelper
  
	# def currency(string)
	# 	newstring = string.split('')
	# 	if newstring.length < 4
	# 		newstring.join.insert(0,'$')
	# 	elsif newstring.length < 7
	# 		newstring.insert(-4,',').insert(0,'$').join
	# 	elsif newstring.length < 10
	# 		newstring.insert(-4,',').insert(-8,',').insert(0,'$').join
	# 	end
	# end

	# def currency(string)
	# 	string.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse.split('').insert(0,'$').join
	# end

	def currency(string)
		"$#{string.to_s.gsub(/\d(?=(...)+$)/, '\0,')}"
	end

	def codestring(string)
		string = /([A-Z][a-z]+[A-Z][a-z]+)/.match(string)[0]
		use_hash = { 'SingleFamily' => 'Single Family Homes', 'Duplex' => 'Two-Family Homes', 'Triplex': 'Three-Family Homes', 'Quadruplex' => 'Multi-Family Homes', 'Condominium' => 'Condominium Homes', 'Cooperative' => 'Condominium Homes', 'Mobile' => 'Mobile Homes', 'MultiFamily2To4' => 'Multi-Family Homes', 'MultiFamily5Plus' => 'Multi-Family Homes', 'Timeshare' => 'Timeshares', 'Miscellaneous' => 'Miscellaneous Homes', 'VacantResidentialLand' => 'Land' }
		@output = use_hash[string]	
	end	

end
