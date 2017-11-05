require_relative "regles.rb"
require_relative "eleve.rb"

#----Méthodes auxiliaires
def lire_fichier(nom_fichier)
	# Créer plusieurs objets Eleve lus du fichier s1.csv, 
	# Mettre en mémoire les objets Eleve dans le Array eleves,
	eleves = Array.new #Création d'un objet Array vide
	f = File.open(nom_fichier, "r")
	while ligne = f.gets
		ligne = ligne.chomp
		infos = ligne.split(";")
		params = { 	:numero => infos[0],
					:nom => infos[1],
					:prenom => infos[2],
					:sexe => infos[3],
					:programme => infos[4],
					:natation => infos[5],
					:anglais => infos[6]
		}
		eleves << Eleve.new(params)
	end
	f.close
	return eleves
end

def afficher(liste)
	liste.each {|element| puts element}	if liste.class == Array
	liste.each {|cle, valeur| puts "#{cle}\t#{valeur}"}	if liste.class == Hash
end

def compter_eleves_dans_le_groupe(groupe, eleves)
	return eleves.select{|eleve| eleve.groupe == groupe}.size
end

def compter_eleves_dans_le_groupe_anglais(cours, eleves)
	return eleves.select{|eleve| eleve.cours_ang == cours}.size
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

def valider?(totaux, maximas)
	return totaux.all?{|groupe, total| total <= maximas[groupe]  }
end

def ecrire_fichier(nom_fichier, eleves)
	f = File.open(nom_fichier, "w")
	eleves.sort{|a,b| a.groupe <=> b.groupe}.each{|eleve| f.write(eleve.to_s + "\n")}
	f.close
end

#-----Programme principal
Eleve.regles(S1)
Eleve.ang(Ang1)


groupes = Max_eleves_par_groupe.keys

cours_ang = Max_eleves_par_groupe_ang.keys

eleves = lire_fichier("s1.csv")

puts "Répartition initiale"
eleves.each {|eleve| eleve.assigner_groupe_au_hasard }

totaux_des_groupes = compter_eleves_de_tous_groupes(groupes, eleves)
totaux_des_groupes_ang = compter_eleves_de_tous_groupes_anglais(cours_ang, eleves)

puts "GROUPES"; afficher(totaux_des_groupes)
puts "ANGLAIS"; afficher(totaux_des_groupes_ang)

fini = false
compteur = 0; max_compteur = 100000

while !fini and compteur < max_compteur
	compteur = compteur + 1
	
	eleve = eleves.sample #Choisir un élève au hasard
	groupe = eleve.groupe
	groupe_anglais = eleve.cours_ang
	
	nombre_eleves = compter_eleves_dans_le_groupe(groupe, eleves)
	nombre_eleves_ang = compter_eleves_dans_le_groupe_anglais(groupe_anglais, eleves)
	
	if 	nombre_eleves > max_eleves_par_groupe[groupe] or 
		nombre_eleves_ang > max_eleves_par_groupe_ang[groupe_anglais]
	then 
		eleve.assigner_groupe_au_hasard
		
		totaux_des_groupes = compter_eleves_de_tous_groupes(groupes, eleves)
		totaux_des_groupes_ang = compter_eleves_de_tous_groupes_anglais(cours_ang, eleves)
		
		fini = 	valider?(totaux_des_groupes, max_eleves_par_groupe) and
				valider?(totaux_des_groupes_ang, max_eleves_par_groupe_ang)
	end
	
end

puts "\nRépartition finale après #{compteur} itérations"

puts "GROUPES"; afficher(totaux_des_groupes)
puts "ANGLAIS"; afficher(totaux_des_groupes_ang)

ecrire_fichier("groupes_s1.txt", eleves)