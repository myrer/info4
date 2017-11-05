#----Méthodes auxiliaires


def afficher(liste)
	liste.each {|element| puts element}	if liste.class == Array
	liste.each {|cle, valeur| puts "#{cle}\t#{valeur}"}	if liste.class == Hash
end

def compter_eleves_dans_le_groupe(groupe, eleves)
	return eleves.find_all{|eleve| eleve.groupe == groupe}.size
end

def compter_eleves_dans_le_groupe_anglais(cours, eleves)
	return eleves.find_all{|eleve| eleve.cours_ang == cours}.size
end

def compter_eleves_dans_le_groupe_musique(cours, eleves)
	return eleves.find_all{|eleve| eleve.cours_musique == cours}.size
end

def compter_eleves_de_tous_groupes(groupes, eleves)
	total = Hash.new
	groupes.each do |groupe| 
		total[groupe] = compter_eleves_dans_le_groupe(groupe, eleves)
	end	
	return total
end

def compter_eleves_de_tous_groupes_anglais(cours_ang, eleves)
	total = Hash.new
	cours_ang.each do |cours| 
		total[cours] = compter_eleves_dans_le_groupe_anglais(cours, eleves)
	end	
	return total
end

def compter_eleves_de_tous_groupes_musique(cours_musique, eleves)
	total = Hash.new
	cours_musique.each do |cours| 
		total[cours] = compter_eleves_dans_le_groupe_musique(cours, eleves)
	end	
	return total
end

def valider?(totaux, maximas)
	return totaux.all?{|groupe, total| total <= maximas[groupe]  }
end

def choisir_eleve_au_hasard(eleves)
	return eleves[rand(eleves.size)]
end

def ecrire_fichier(nom_fichier, eleves)
	f = File.open(nom_fichier, "w")
	eleves.sort{|a,b| a.groupe <=> b.groupe}.each{|eleve| f.write(eleve.to_s + "\n")}
	f.close
end

def former_groupes
	groupes = Max_eleves_par_groupe.keys
	cours_ang = Max_eleves_par_groupe_ang.keys

	eleves = Eleve.all

	eleves.each {|eleve| eleve.assigner_groupe_au_hasard }

	totaux_des_groupes = compter_eleves_de_tous_groupes(groupes, eleves)
	totaux_des_groupes_ang = compter_eleves_de_tous_groupes_anglais(cours_ang, eleves)

	#~ puts "GROUPES"; afficher(totaux_des_groupes)
	#~ puts "ANGLAIS"; afficher(totaux_des_groupes_ang)

	fini = false
	compteur = 0; max_compteur = 100000

	while !fini and compteur < max_compteur
		compteur = compteur + 1
		
		eleve = eleves.sample #Choisir un élève au hasard
		groupe = eleve.groupe
		groupe_anglais = eleve.cours_ang
		
		nombre_eleves = compter_eleves_dans_le_groupe(groupe, eleves)
		nombre_eleves_ang = compter_eleves_dans_le_groupe_anglais(groupe_anglais, eleves)
		
		if 	nombre_eleves > Max_eleves_par_groupe[groupe] or 
			nombre_eleves_ang > Max_eleves_par_groupe_ang[groupe_anglais]
		then 
			eleve.assigner_groupe_au_hasard
			
			totaux_des_groupes = compter_eleves_de_tous_groupes(groupes, eleves)
			totaux_des_groupes_ang = compter_eleves_de_tous_groupes_anglais(cours_ang, eleves)
			
			fini = 	valider?(totaux_des_groupes, Max_eleves_par_groupe) and
					valider?(totaux_des_groupes_ang, Max_eleves_par_groupe_ang)
		end
		
	end

	#~ puts "\nRépartition finale après #{compteur} itérations"

	#~ puts "GROUPES"; afficher(totaux_des_groupes)
	#~ puts "ANGLAIS"; afficher(totaux_des_groupes_ang)

	#~ ecrire_fichier("groupes_s1.txt", eleves)
end