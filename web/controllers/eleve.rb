def former_groupes
	eleves = Eleve.tous
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
end