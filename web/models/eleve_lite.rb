class Eleve
	
	@@tous = []
	
	attr_reader :numero, :nom, :prenom, :sexe, :niveau, :groupe, :natation, :attributs
	
	def initialize(params) #params est un Hash qui contiendra les éléments requis pour construire un Eleve
		
		@numero = params[:numero]
		@niveau = params[:niveau]
		@nom = params[:nom]
		@prenom = params[:prenom]
		@sexe = params[:sexe]
		@natation = params[:natation]
		@attributs = params[:attributs]
		
		@@tous << self
	end
	
	def Eleve.tous
		@@tous
	end
	
	def Eleve.lire_fichier(nom_fichier)
		rapport = []
		f = File.open(nom_fichier, "r")
		while ligne = f.gets
			ligne = ligne.chomp
			infos = ligne.split(";")
			params = { 	:numero => infos[0],
						:niveau => infos[1],
						:nom => infos[2],
						:prenom => infos[3],
						:sexe => infos[4],
						:natation => infos[5],
						:attributs => infos[6..-1]
			}
			if eleve = @@tous.find{|x| x.numero == params[:numero]}
				rapport << "Existe déjà : #{eleve}"
			else
				eleve = Eleve.new(params)
				rapport << "Ajout de : #{eleve}"
			end	
		end
		f.close
		return rapport
	end

end

