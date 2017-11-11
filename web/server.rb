require 'erb'
require 'webrick'

require_relative "models/regle.rb"
require_relative "models/eleve.rb"
require_relative "models/groupe.rb"
require_relative "models/classe.rb"

require_relative "controllers/application.rb"
require_relative "controllers/regle.rb"
require_relative "controllers/eleve.rb"
require_relative "controllers/groupe.rb"
require_relative "controllers/classe.rb"

#-----
Groupe.lire_fichier("assets/groupes.csv")
Regle.lire_fichier("assets/regles.csv")
Classe.lire_fichier("assets/classes.csv")
#~ Eleve.lire_fichier("assets/s1.csv")
#~ Eleve.lire_fichier("assets/s2.csv")
#-----


Local_root = "/home/rick/rbf/info4/web/"

server = WEBrick::HTTPServer.new({ :Port => 8000, :DocumentRoot => Local_root + "views"})

WEBrick::HTTPUtils::DefaultMimeTypes.store('rhtml', 'text/html') # Add a mime type for *.rhtml files

trap 'INT' do server.shutdown end

server.mount("/", WEBrick::HTTPServlet::FileHandler, Local_root + "views")

server.start