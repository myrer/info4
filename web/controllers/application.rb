def head 
	"<head> <meta charset='UTF-8'>	</head>"
end

def entete
	render("views/entete.html")
end

def ouverture
	str = "<html>"
	str << head
	str << "<body>"
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