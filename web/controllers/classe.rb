def classes_index_controller(requete)
	case requete['ordre']
	when 'niveau'	
		classes = Classe.tous.sort {|a,b| a.niveau+a.nom <=> b.niveau+b.nom}
	when 'attribut'	
		classes = Classe.tous.sort {|a,b| a.attribut+a.nom <=> b.attribut+b.nom}
	else
		classes = Classe.tous.sort {|a,b| a.nom+a.niveau <=> b.nom+b.niveau }
	end
	return classes
end

def configurer_classe_modifier(servlet_request)
	@classe = Classe.obtenir(servlet_request.query['nom'])
	@select_niveau_params = { 
		:name => "niveau",
		:options => Niveaux,
		:selected => @classe.niveau
	}
	@checkbox_groupes_permis_params = {
		:name => "groupes[]",
		:options => Groupe.niveau(@classe.niveau).collect{|g| g.nom},
		:checked => @classe.groupes_permis_str.split(";")
	}
end

def configurer_classe_soumettre(servlet_request)
	data = servlet_request.body.split("&").select{|x| x=~/groupes/}
	groupes_permis_ary = data.collect{|x| x.split("=")[1]}
	
	@classe = Classe.obtenir(servlet_request.query['nom_initial'])
	
	@classe.nom = servlet_request.query['nom']
	@classe.niveau = servlet_request.query['niveau']
	@classe.groupes_permis = groupes_permis_ary
	@classe.attribut = servlet_request.query['attribut']
	@classe.max_eleves=servlet_request.query['max_eleves']
	
	puts @classe
end
