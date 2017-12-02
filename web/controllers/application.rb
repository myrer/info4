Niveaux = %w[P5 P6 S1 S2 S3 S4 S5]

def my_render(file_name, b = nil)
	f = File.open(file_name, "r")
	str = ""
	while line = f.gets
		str << line
	end
	f.close
	if b.nil?
		return str
	else
		return ERB.new(str).result(b)
	end	
end

