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

def total_groupe(groupe, eleves)
	return eleves.find_all{|eleve| eleve.groupe == groupe}.size
end

def total_cours_ang(cours, eleves)
	return eleves.find_all{|eleve| eleve.cours_ang == cours}.size
end

def total_groupes(groupes, eleves)
	total = Hash.new
	groupes.each do |groupe| 
		total[groupe] = total_groupe(groupe, eleves)
	end	
	return total
end

def total_ang(cours_ang, eleves)
	total = Hash.new
	cours_ang.each do |cours| 
		total[cours] = total_cours_ang(cours, eleves)
	end	
	return total
end

def valide?(totaux, maximas)
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

#-----Programme principal

max_reg = 31
max_enr = 35

contraintes_groupe = {
	"101" => max_reg,  
	"103" => max_reg, 
	"105" => max_reg, 
	"107" => max_reg, 
	"109" => max_reg, 
	"110" => max_reg, 
	"111" => max_reg,
	"102" => max_enr, 
	"104" => max_enr, 
	"106" => max_enr, 
	"108" => max_enr 
}

groupes = contraintes_groupe.keys

contraintes_ang = {
	"ELA104-00001" => 34, 
	"ELA104-00007" => 34, 
			
	"EESL104-00001" => 35,
	"EESL104-00003" => 34,
	"EESL104-00005" => 34, 
	"EESL104-00009" => 35, 
			
	"ESL104-00003" => 32, 
	"ESL104-00005" => 32, 
	"ESL104-00007" => 32, 
	"ESL104-00009" => 31, 
	"ESL104-00111" => 31 
}

cours_ang = contraintes_ang.keys

eleves = lire_fichier("s1.csv")

puts "Répartition initiale"
eleves.each {|eleve| eleve.assigner_groupe_au_hasard }

puts "GROUPES"
totaux_gr = total_groupes(groupes, eleves)
afficher(totaux_gr)
puts "ANGLAIS"
totaux_ang = total_ang(cours_ang, eleves)
afficher(totaux_ang)

fini = false
cnt = 0
while !fini
	cnt = cnt + 1
	#~ puts cnt
	eleve = choisir_eleve_au_hasard(eleves)
	groupe = eleve.groupe
	ang = eleve.cours_ang
	nombre_eleves = total_groupe(groupe, eleves)
	nombre_eleves_ang = total_cours_ang(ang, eleves)
	
	if nombre_eleves > contraintes_groupe[groupe] or nombre_eleves_ang > contraintes_ang[ang]
	then 
		eleve.assigner_groupe_au_hasard
		totaux_gr = total_groupes(groupes, eleves)
		totaux_ang = total_ang(cours_ang, eleves)
		v1 = valide?(totaux_gr, contraintes_groupe)
		v2 = valide?(totaux_ang, contraintes_ang)
		fini =  (v1 and v2)
	end
	
end

puts
puts "Répartition finale"
puts "itérations : #{cnt}"

puts "GROUPES"
afficher(totaux_gr)
puts "ANGLAIS"
afficher(totaux_ang)

ecrire_fichier("groupes_s1.txt", eleves)

#~ afficher eleves