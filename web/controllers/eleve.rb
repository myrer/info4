def eleves_index_controller(requete)
	case requete['ordre']
	when 'niveau'
		eleves = Eleve.tous.sort{|a,b| a.niveau+a.nom+a.prenom <=> b.niveau+b.nom+b.prenom}
	when 'groupe'
		eleves = Eleve.tous.sort{|a,b| a.groupe_nom+a.nom+a.prenom <=> b.groupe_nom+b.nom+b.prenom}
	when 'nom'
		eleves = Eleve.tous.sort{|a,b| a.nom+a.prenom <=> b.nom+b.prenom}
	when 'prenom'
		eleves = Eleve.tous.sort{|a,b| a.prenom+a.nom <=> b.prenom+b.nom}
	when 'sexe'
		eleves = Eleve.tous.sort{|a,b| a.sexe+a.nom+a.prenom <=>b.sexe+b.nom+b.prenom}
	when 'natation'
		eleves = Eleve.tous.sort{|a,b| 	a.natation.rjust(2,"0")+a.niveau+a.nom+a.prenom <=>
										b.natation.rjust(2,"0")+b.niveau+b.sexe+b.nom+b.prenom}
	when 'attributs'
		eleves = Eleve.tous.sort{|a,b| 	a.attributs.join("")+a.niveau+a.nom+a.prenom <=>
										b.attributs.join("")+b.niveau+b.sexe+b.nom+b.prenom}
	else
		eleves = Eleve.tous.sort{|a,b| a.numero <=> b.numero}
	end	
	return eleves
end

def configurer_eleve_liste(servlet_request)
	@niveau = servlet_request.query['niveau']
	@eleves = Eleve.tous.select{|e| e.niveau == @niveau}.sort {|a,b| a.nom+a.prenom <=> b.nom+b.prenom }
end

def configurer_eleve_importer(servlet_request)
	niveau = servlet_request.query['niveau'].downcase
	@rapport = Eleve.importer("assets/#{niveau}.csv")
end