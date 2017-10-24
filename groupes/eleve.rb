# eleve.rb : Eleve est une représentation d'un élève de S1 à JDLM
class Eleve
		
	attr_reader :numero, :nom, :prenom, :sexe, :programme, :natation, :anglais, :groupe, :cours_ang
	
	def initialize(params) #params est un Hash qui contiendra les éléments requis pour construire un Eleve
		
		@numero = params[:numero]
		@nom = params[:nom]
		@prenom = params[:prenom]
		@sexe = params[:sexe]
		@programme = params[:programme]
		@natation = params[:natation]
		@anglais = params[:anglais]
		
		#configurer groupes_permis
		@groupes_permis = @@regles[@programme] & @@regles[@anglais] 
		
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
		else
			groupe = @groupe
			cours_ang = @cours_ang	
		end	
		
		"#{@numero}\t#{@nom.ljust(20, " ")}#{@prenom.ljust(20, " ")}" + 
		"#{@sexe}\t#{@programme}\t#{@natation}\t#{@anglais.ljust(4, " ")}\t<#{groupe}> <#{cours_ang}>\t[#{groupes}]"
	end
	
	def assigner_groupe(groupe)
		if  @groupes_permis.include?(groupe)
		then 
			@groupe = groupe
			assigner_ang
		end
	end
	
	def assigner_groupe_au_hasard
		@groupe = @groupes_permis.sample #Choisir un groupe au hasard
		assigner_ang
	end
	
	def self.regles(niveau)
		@@regles = niveau
	end
	
	def self.ang(ang)
		@@ang = ang
	end	
	
private
	def assigner_ang
		@cours_ang = @@ang["#{@groupe}-#{@anglais}"]
	end
end

