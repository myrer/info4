require_relative "regles.rb"

class Eleve
	
	@@tous = []
	
	attr_reader :numero, :nom, :prenom, :sexe, :programme, :natation, :anglais, :groupe, :inscriptions #Tous
	attr_reader :musique #S2
	
	def initialize(params) #params est un Hash qui contiendra les éléments requis pour construire un Eleve
		
		@numero = params[:numero]
		@nom = params[:nom]
		@prenom = params[:prenom]
		@sexe = params[:sexe]
		@programme = params[:programme]
		@natation = params[:natation]
		@anglais = params[:anglais]
		@inscriptions = []
		
		case @@regles
		when S1
			@musique = ""
		when S2 
			@musique = params[:musique] 
		end
		
		#configurer groupes_permis
		@groupes_permis = 	@@regles[@programme] & @@regles[@anglais] 
		
		case @@regles
		when S2	
			@groupes_permis = @groupes_permis & @@regles[@musique]
		end
		
		@@tous << self
	end
	
	def to_s
		if @groupes_permis.empty? == true
		then groupes = "AUCUN!"
		else groupes = @groupes_permis.join(", ") 
		end
		
		if @groupe.nil?
		then 
			groupe = ""
		else
			groupe = @groupe
		end	
		
		"#{@numero}\t#{@nom.ljust(20, " ")}#{@prenom.ljust(20, " ")}" + 
		"#{@sexe}\t#{@programme}\t#{@natation}\t#{@anglais.ljust(4, " ")}\t" + 
		"#{@musique.ljust(4, " ")}\t #{groupe}"  + 
		"[#{groupes}]"
	end
	
	def assigner_groupe(groupe)
		if  @groupes_permis.include?(groupe)
		then 
			@groupe = groupe
			supprimer_inscriptions
			assigner_base
			assigner_musique 
		end
	end
	
	def assigner_groupe_au_hasard
		@groupe = @groupes_permis[rand(@groupes_permis.size)]
		supprimer_inscriptions
		assigner_base
		assigner_musique 
	end

	def supprimer_inscriptions
		@inscriptions = []
	end
	
	def self.regles(niveau)
		@@regles = niveau
	end
	
	def self.ang(ang)
		@@ang = ang
	end

	def self.mus(musique)
		@@mus = musique
	end	
	
	def self.all
		@@tous
	end

	def self.tous
		@@tous
	end
	
	def self.lire_fichier(nom_fichier)
		f = File.open(nom_fichier, "r")
		while ligne = f.gets
			ligne = ligne.chomp
			infos = ligne.split(";")
			params = { 	:numero => infos[0],
						:nom => infos[1],
						:prenom => infos[2],
						:sexe => infos[3],
						:programme => infos[4],
						:natation => infos[5],
						:anglais => infos[6],
						:musique => infos[7]
			}
			Eleve.new(params)
		end
		f.close
	end

private
	def assigner_base
		@inscriptions << "ABS100-#{@groupe.rjust(5, '0')}"
		@inscriptions << @@ang["#{@groupe}-#{@anglais}"]
	end
	
	def assigner_musique
		case @@regles
		when S2 
			@inscriptions = @@mus["#{@groupe}-#{@musique}"]
		end	
	end
end

