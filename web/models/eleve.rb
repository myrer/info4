class Eleve
	
	@@tous = []
	
	attr_reader :numero, :nom, :prenom, :sexe, :niveau, :groupe, :natation, :attributs
	attr_reader :classes
	
	def initialize(params) #params est un Hash qui contiendra les éléments requis pour construire un Eleve
		
		@numero = params[:numero]
		@niveau = params[:niveau]
		@nom = params[:nom]
		@prenom = params[:prenom]
		@sexe = params[:sexe]
		@natation = params[:natation]
		@attributs = params[:attributs]
		
		@regles = Regle.niveau(@niveau)
		
		@classes = []
		
		#configurer groupes_permis
		@groupes_permis = Groupe.niveau(@niveau)
		
		@attributs.each do |attribut|
			regle = @regles.find{|regle| regle.attribut == attribut }
			@groupes_permis = @groupes_permis & regle.groupes_permis
		end	
		
		@@tous << self
	end
	
	def to_s
		if @groupes_permis.empty? == true
		then groupes = "AUCUN!"
		else groupes = @groupes_permis.collect{|x| x.nom}.join(", ") 
		end
		
		if @groupe.nil?
		then 
			groupe = ""
		else
			groupe = @groupe.nom
		end	
		
		"#{@numero};#{@niveau};#{groupe};#{@nom};#{@prenom};#{@sexe};#{@natation};" + 
		"#{@attributs.join(";")};"  + 
		"[#{groupes}];"
	end
	
	def assigner_groupe(groupe)
		if  @groupes_permis.include?(groupe)
		then 
			@groupe = groupe
			assigner_classes
		end
	end
	
	def assigner_groupe_au_hasard
		@groupe = @groupes_permis[rand(@groupes_permis.size)]
		assigner_classes
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
						:niveau => infos[1],
						:nom => infos[2],
						:prenom => infos[3],
						:sexe => infos[4],
						:natation => infos[5],
						:attributs => infos[6..-1]
			}
			Eleve.new(params)
		end
		f.close
	end

private
	def assigner_classes
		@classes = []
		@attributs.each do |attribut|
			@classes << Classe.assigner(@groupe, attribut)
		end	
	end
end

