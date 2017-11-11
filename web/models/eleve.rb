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
			raise "Pas de règle :  #{attribut} #{self}" if regle.nil?
			@groupes_permis = @groupes_permis & regle.groupes_permis
		end	
		
		@@tous << self
	end
	
	def groupes_permis_str
		if @groupes_permis.nil?
			return "Aucun"
		else
			return @groupes_permis.collect{|x| x.nom}.join(";") 
		end	
	end
	
	def groupe_nom
		if @groupe.nil?
			return  "?"
		else
			return @groupe.nom
		end	
	end
	
	def to_s
		"#{@numero};#{@niveau};#{groupe_nom};#{@nom};#{@prenom};#{@sexe};#{@natation};" + 
		"#{@attributs.join(";")};"  + 
		"[#{groupes_permis_str}];"
	end
	
	def assigner_groupe(groupe)
		if  @groupes_permis.include?(groupe)
		then 
			@groupe = groupe
			assigner_classes
		end
	end
	
	def assigner_groupe_au_hasard
		@groupe = @groupes_permis.sample
		assigner_classes
	end
	
	def self.tous
		@@tous
	end
	
	def self.importer(nom_fichier)
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

private
	def assigner_classes
		@classes = []
		@attributs.each do |attribut|
			@classes << Classe.assigner(@groupe, attribut)
		end	
	end
end

