def configurer_groupe_index(servlet_request)
	@niveau = servlet_request.query['niveau']
	@groupes = Groupe.tous.select{|groupe| groupe.niveau == @niveau}.sort {|a,b| a.nom <=> b.nom }
end

def configurer_groupe_afficher(servlet_request)
	nom = servlet_request.query['nom']
	@groupe = Groupe.obtenir(nom)
	@eleves = @groupe.eleves.sort{|a,b| a.nom+a.prenom <=> b.nom+b.prenom}
end

def configurer_groupe_former(servlet_request)
	niveau = servlet_request.query['niveau']
	former_groupes(niveau)
	@groupes = Groupe.tous.select{|groupe| groupe.niveau == niveau}
	@classes = Classe.tous.select{|classe| classe.niveau == niveau}
end

def former_groupes(niveau)
	eleves = Eleve.tous.select{|eleve| eleve.niveau == niveau}
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
	@compteur = compteur
end