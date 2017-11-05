require 'erb'
require 'webrick'

require_relative "models/eleve.rb"
require_relative "models/groupe.rb"
require_relative "models/classe.rb"

require_relative "controllers/eleve.rb"
require_relative "servlets/eleve.rb"

#-----
Eleve.regles(S1)
Eleve.ang(Ang1)
Eleve.mus(Mus1)
Eleve.lire_fichier("assets/s1.csv")
Groupe.lire_fichier("assets/groupes.csv")
Classe.lire_fichier("assets/classes.csv")

#-----


Local_root = "/home/rick/rbf/info4/web/"

server = WEBrick::HTTPServer.new({ :Port => 8000, :DocumentRoot => Local_root + "views"})

WEBrick::HTTPUtils::DefaultMimeTypes.store('rhtml', 'text/html') # Add a mime type for *.rhtml files

trap 'INT' do server.shutdown end

server.mount("/", WEBrick::HTTPServlet::FileHandler, Local_root + "views")

server.start