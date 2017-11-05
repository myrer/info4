class Classe
	@@tous = []
	attr_reader :nom, :niveau, :max_eleves
	
	def initialize(params)
		@nom = params[:nom]
		@niveau = params[:niveau]
		@max_eleves = params[:max_eleves].to_i
		
		@@tous << self	
	end

	def to_s
		"#{@nom}\t#{@niveau}\t#{max_eleves}"
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
		Eleve.tous.select{|eleve| eleve.classes.find{|x| x.nom == @nom} }
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
						:max_eleves => infos[2],
			}
			Classe.new(params)
		end
		f.close
	end
end