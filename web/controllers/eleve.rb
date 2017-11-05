#----Méthodes auxiliaires

def afficher(liste)
	liste.each {|element| puts element}	if liste.class == Array
	liste.each {|cle, valeur| puts "#{cle}\t#{valeur}"}	if liste.class == Hash
end

def ecrire_fichier(nom_fichier, eleves)
	f = File.open(nom_fichier, "w")
	eleves.sort{|a,b| a.groupe <=> b.groupe}.each{|eleve| f.write(eleve.to_s + "\n")}
	f.close
end

def former_groupes
	eleves = Eleve.tous
	eleves.each {|eleve| eleve.assigner_groupe_au_hasard }

	fini = false
	compteur = 0; max_compteur = 10000

	while !fini and compteur < max_compteur
		compteur = compteur + 1
		
		eleve = eleves.sample #Choisir un élève au hasard
		
		classes = eleve.inscriptions.collect{|x| Classe.obtenir(x)}
		
		if classes.any? {|classe| classe.total > Max_eleves_par_classe[classe.nom] }
		then 
			eleve.assigner_groupe_au_hasard
			fini = 	Classe.tous.all? {|classe| classe.total <= Max_eleves_par_classe[classe.nom]}
		end
	end
end