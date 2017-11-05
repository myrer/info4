class Regle
	@@tous = []
	attr_reader :niveau, :attribut, :noms_des_groupes
	
	def initialize(params)
		@niveau = params[:niveau]
		@attribut = params[:attribut]
		@noms_des_groupes = params[:noms_des_groupes]
		puts self
		@@tous << self	
	end

	def to_s
		"#{@niveau}\t#{@attribut}\t#{@noms_des_groupes}"
	end
	
	def eleves
		Eleve.tous.select{|eleve| eleve.classes.find{|x| x.nom == @nom} }
	end
	
	def self.tous
		@@tous
	end
	
	def self.obtenir(niveau, attribut)
		@@tous.find{|x| x.niveau == nivau && x.attribut == attribut }
	end
	
	def self.lire_fichier(nom_fichier)
		f = File.open(nom_fichier, "r")
		while ligne = f.gets
			ligne = ligne.chomp
			infos = ligne.split(";")
			params = { 	:niveau => infos[0],
						:attribut => infos[1],
						:noms_des_groupes => infos[2],
			}
			Regle.new(params)
		end
		f.close
	end
end