class Groupe
	@@tous = []
	attr_reader :nom, :niveau
	
	def initialize(params)
		@nom = params[:nom]
		@niveau = params[:niveau]
		@@tous << self	
	end

	def id
		@nom
	end
	
	def to_s
		"#{@nom};#{@niveau};"
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
		Eleve.tous.select{|eleve| eleve.groupe == self }
	end
	
	def self.tous
		@@tous
	end
	
	def self.obtenir(id)
		rv = @@tous.find{|x| x.id == id}
	end
	
	def Groupe.niveau(niveau)
		@@tous.select{|groupe| groupe.niveau == niveau}
	end
	
	def self.lire_fichier(nom_fichier)
		f = File.open(nom_fichier, "r")
		while ligne = f.gets
			ligne = ligne.chomp
			infos = ligne.split(";")
			params = { 	:nom => infos[0].strip,
						:niveau => infos[1].strip,
			}
			Groupe.new(params)
		end
		f.close
	end
end