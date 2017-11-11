def ouverture
	str = "<html>"
	str << "<head> <meta charset='UTF-8'>	</head>"
	str << "<body>"
	str << render("views/entete.html")
end

def fermeture
	"</body></html>"
end

def render(file_name)
	f = File.open(file_name, "r")
	str = ""
	while line = f.gets
		str << line
	end
	f.close
	return str
end