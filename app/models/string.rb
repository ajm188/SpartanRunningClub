class String
	def titlize
		split(' ').each { |word| word.capitalize! }.join ' '
	end
end