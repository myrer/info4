class Regle
	@@tous = []
	attr_reader :niveau, :attribut, :groupes_permis
	
	def initialize(params)
		@niveau = params[:niveau]
		@attribut = params[:attribut]
		@groupes_permis = params[:groupes_permis].split(",").collect {|nom_du_groupe| 
			Groupe.obtenir(nom_du_groupe)
		}
		
		@@tous << self	
	end
	
	def to_s
		"#{@niveau}\t#{@attribut}\t#{@groupes_permis.collect{|x| x.nom}.join(",")}"
	end
	
	def eleves
		Eleve.tous.select{|eleve| eleve.classes.find{|x| x.nom == @nom} }
	end
	
	def self.tous
		@@tous
	end
	
	def self.niveau(niveau)
		@@tous.select{|x| x.niveau == niveau }
	end
	
	def self.lire_fichier(nom_fichier)
		f = File.open(nom_fichier, "r")
		while ligne = f.gets
			ligne = ligne.chomp
			infos = ligne.split(";")
			params = { 	:niveau => infos[0],
						:attribut => infos[1],
						:groupes_permis => infos[2],
			}
			Regle.new(params)
		end
		f.close
	end
end