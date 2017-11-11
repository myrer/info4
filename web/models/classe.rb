class Classe
	@@tous = []
	attr_reader :nom, :niveau, :max_eleves, :attribut, :groupes_permis
	
	def initialize(params)
		@nom = params[:nom]
		@niveau = params[:niveau]
		@attribut = params[:attribut]
		@max_eleves = params[:max_eleves].to_i
		@groupes_permis = configurer_groupes_permis(params[:groupes_permis])
		@@tous << self	
	end
	
	def groupes_permis_str
		@groupes_permis.collect{|x| x.nom}.join(",") 
	end
	
	def to_s
		"#{@nom};#{@niveau};#{@attribut};#{@max_eleves};#{groupes_permis_str}"
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
		Eleve.tous.select{|eleve| eleve.classes.include?(self) }
	end
	
	def self.tous
		@@tous
	end

	def self.niveau(niveau)
		@@tous.select{|classe| classe.niveau == niveau}
	end
	
	def self.obtenir(nom)
		@@tous.find{|classe| classe.nom == nom}
	end
	
	def self.assigner(groupe, attribut)
		@@tous.find{|classe| classe.groupes_permis.include?(groupe) and classe.attribut == attribut}
	end

	def self.lire_fichier(nom_fichier)
		f = File.open(nom_fichier, "r")
		while ligne = f.gets
			ligne = ligne.chomp
			infos = ligne.split(";")
			params = { 	:nom => infos[0],
						:niveau => infos[1],
						:attribut => infos[2],
						:max_eleves => infos[3],
						:groupes_permis => infos[4..-1]
			}
			Classe.new(params)
		end
		f.close
	end

private
	def configurer_groupes_permis(param)
		param.collect{|x| Groupe.obtenir(x) }
	end
end