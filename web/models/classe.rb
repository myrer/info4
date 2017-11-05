class Classe
	@@tous = []
	attr_reader :nom, :niveau
	
	def initialize(params)
		@nom = params[:nom]
		@niveau = params[:niveau]
		@@tous << self	
	end

	def to_s
		"#{@nom}\t#{@niveau}"
	end
	
	def total
		if eleves.empty?
			rv = 0
		else
			rv = eleves.size
		end
		return rv
	end

	def eleves
		Eleve.tous.select{|eleve| eleve.inscriptions.include?(@nom)}
	end
	
	def self.tous
		@@tous
	end
	
	def self.obtenir(nom)
		@@tous.find{|x| x.nom == nom}
	end
	
	def self.lire_fichier(nom_fichier)
		f = File.open(nom_fichier, "r")
		while ligne = f.gets
			ligne = ligne.chomp
			infos = ligne.split(";")
			params = { 	:nom => infos[0],
						:niveau => infos[1],
			}
			Classe.new(params)
		end
		f.close
	end
end