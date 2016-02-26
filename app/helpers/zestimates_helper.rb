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

end
