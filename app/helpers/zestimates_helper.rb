module ZestimatesHelper

	def currency(string)
		"$#{string.to_s.gsub(/\d(?=(...)+$)/, '\0,')}"
	end

	def codestring(string)
		string = /([A-Z][a-zA-Z\d]+)/.match(string)[0]
		@output = string
		use_hash = { '' => 'homes', 'SingleFamily' => 'Single Family Homes', 'Duplex' => 'Two-Family Homes', 'Triplex': 'Three-Family Homes', 'Quadruplex' => 'Multi-Family Homes', 'Condominium' => 'Condominium Homes', 'Cooperative' => 'Condominium Homes', 'Mobile' => 'Mobile Homes', 'MultiFamily2To4' => 'Multi-Family Homes', 'MultiFamily5Plus' => 'Multi-Family Homes', 'Timeshare' => 'Timeshares', 'Miscellaneous' => 'Miscellaneous Homes', 'VacantResidentialLand' => 'Land' }
		@output = use_hash[string]	
	end	

	def cleantime(string)
		string = string.to_s.gsub(/ -0\d00/,'')
	end

	def answer(int)
		int == 1? "Yes": "No"
	end	

	def select_agent
		agent_id ||= 1 #set initial agent id
		agent_hash = { '1' => 'rachael@wordaroundtown.com', '2' => 'rachael@eplacehomes.com'}
		@assigned_agent = agent_hash[agent_id]
		agent_id < 2? agent_id += 1: agent_id = 1
	end

end

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

