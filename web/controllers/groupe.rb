def groupes_index_controller(requete)
	case requete['ordre']
	when 'niveau'
		groupes = Groupe.tous.sort {|a,b| a.niveau+a.nom <=> b.niveau+b.nom}
	else
		groupes = Groupe.tous.sort {|a,b| a.nom <=> b.nom }
	end	
	return groupes
end

def groupes_afficher_controller(requete)
	id = requete['id']
	groupe = Groupe.obtenir(id)
	eleves = groupe.eleves.sort{|a,b| a.nom+a.prenom <=> b.nom+b.prenom}
	return groupe, eleves
end

def groupes_former_controller(requete)
	niveau = requete['niveau']
	eleves = Eleve.tous.select{|eleve| eleve.niveau == niveau}
	if eleves.empty?
		message = "Aucun élève dans le niveau #{niveau}."
		compteur = 0
		groupes = []
		classes = []
	else	
		compteur = former_groupes(eleves)
		classes = Classe.tous.select{|classe| classe.niveau == niveau}
	end	
	return niveau, compteur, message, classes
end

def former_groupes(eleves)
	eleves.each {|eleve| eleve.assigner_groupe_au_hasard }
	fini = false
	compteur = 0; max_compteur = 10000
	classes_du_niveau = Classe.niveau(eleves[0].niveau)
	while !fini and compteur < max_compteur
		compteur = compteur + 1
		eleve = eleves.sample #Choisir un élève au hasard
		
		if eleve.classes.any? {|classe| classe.total > classe.max_eleves }
		then 
			eleve.assigner_groupe_au_hasard
			fini = 	classes_du_niveau.all? {|classe| classe.total <= classe.max_eleves }
		end
	end
	return compteur
end