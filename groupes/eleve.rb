# eleve.rb : Eleve est une représentation d'un élève de S1 à JDLM
class Eleve
		
	attr_reader :numero, :nom, :prenom, :sexe, :programme, :natation, :anglais, :groupe, :cours_ang
	attr_reader :musique, :cours_musique
	
	def initialize(params) #params est un Hash qui contiendra les éléments requis pour construire un Eleve
		
		@numero = params[:numero]
		@nom = params[:nom]
		@prenom = params[:prenom]
		@sexe = params[:sexe]
		@programme = params[:programme]
		@natation = params[:natation]
		@anglais = params[:anglais]
		@musique = params[:musique]
		
		#configurer groupes_permis
		@groupes_permis = 	@@regles[@programme]
		@groupes_permis = @groupes_permis & @@regles[@anglais] 
		@groupes_permis = @groupes_permis & @@regles[@musique] 
		
	end
	
	def to_s
		if @groupes_permis.empty? == true
		then groupes = "AUCUN!"
		else groupes = @groupes_permis.join(", ") 
		end
		
		if @groupe.nil?
		then 
			groupe = ""
			cours_ang = ""
			cours_musique = ""
		else
			groupe = @groupe
			cours_ang = @cours_ang	
			cours_musique = @cours_musique
		end	
		
		"#{@numero}\t#{@nom.ljust(20, " ")}#{@prenom.ljust(20, " ")}" + 
		"#{@sexe}\t#{@programme}\t#{@natation}\t#{@anglais.ljust(4, " ")}\t#{@musique.ljust(4, " ")}\t<#{groupe}> <#{cours_ang}>\t <#{cours_musique}>\t [#{groupes}]"
	end
	
	def assigner_groupe(groupe)
		if  @groupes_permis.include?(groupe)
		then 
			@groupe = groupe
			assigner_ang
			assigner_musique
		end
	end
	
	def assigner_groupe_au_hasard
		@groupe = @groupes_permis[rand(@groupes_permis.size)]
		assigner_ang
		assigner_musique
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
	
private
	def assigner_ang
		@cours_ang = @@ang["#{@groupe}-#{@anglais}"]
	end
	
	def assigner_musique
		@cours_musique = @@mus["#{@groupe}-#{@musique}"]
	end
end

