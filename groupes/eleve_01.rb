# eleve.rb
#
# Définissons un Class qui ne nomme Eleve.
# Eleve sera une représentation d'un élève de S1 à JDLM
#

class Eleve
	
	def initialize(params) #params est un Hash qui contiendra les éléments requis pour construire un Eleve
		
		@numero = params[:numero]
		@nom = params[:nom].encode("utf-8")
		@prenom = params[:prenom]
		@sexe = params[:sexe]
		@programme = params[:programme]
		@natation = params[:natation]
		@anglais = params[:anglais]
	end
	
	attr_reader :numero, :nom, :prenom, :sexe, :programme, :natation, :anglais
	
	def to_s
		"#{@numero}\t#{@nom.ljust(20, " ")}\t" + 
		"#{@prenom.ljust(20, " ")}\t#{@sexe}\t#{@programme}\t#{@natation}\t#{@anglais}"
	end
end

#---- PROGRAMME PRINCIPAL

# Exemple 1 : Création d'un objet Eleve.
puts "Exemple 1"
params = { 	:numero => '007',
			:nom => "Bond",
			:prenom => "James",
			:sexe => "M",
			:programme => "enr",
			:natation => "12",
			:anglais => 'ela'
		}
james = Eleve.new(params)
puts james.nom

# Exemple 2 : Créer plusieurs objets Eleve lus du fichier s1.csv, 
#                    mettre en mémoire les objets Eleve dans le Array eleves,
#                    afficher tous les objets Eleve.
puts "Exemple 2"
eleves = Array.new #Création d'un objet Array vide

f = File.open("s1.csv", "r")
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

# Afficher tous les objets Eleve
eleves.each {|eleve| puts eleve}

# Exemple 3 : Afficher tous les objets Eleves ayant un nom comptant moins de 4 lettres
puts "Exemple 3"
eleves.each do |eleve| 
	if eleve.nom.size  <= 4
	then puts eleve
	end
end

# Exemple 4 : Compter et afficher le nombre de gars et de filles en S1
puts "Exemple 4"

n_gars = 0
n_filles = 0
eleves.each do |eleve| 
	if eleve.sexe == "M"
	then n_gars = n_gars + 1
	else n_filles = n_filles + 1
	end
end
puts "Total #{eleves.size} : #{n_gars} gars et #{n_filles} filles "

# Exemple 5 : Compter et afficher le nombre de gars et de filles en enrichi en S1
puts "Exemple 5"
n_gars = 0
n_filles = 0
eleves.each do |eleve| 
	if eleve.sexe == "M" and eleve.programme == "enr"
	then n_gars = n_gars + 1
	end
	if eleve.sexe == "F" and eleve.programme == "enr"
	then n_filles = n_filles + 1
	end
end
total_enr = n_gars + n_filles
puts "Enrichi #{total_enr} : #{n_gars} gars et #{n_filles} filles "

#
# Ce type de recherche est tellement commun, que Ruby nous offre une méthode très utile find_all
#

#Exemple 6 : Compter et afficher le nombre de gars en enrichi qui sont en eesl en anglais
puts "Exemple 6"
gars = eleves.find_all{|eleve| eleve.sexe == "M" and eleve.programme == "enr" and eleve.anglais == "EESL"}
puts "Gars, enr, eesl : #{gars.size}"

#Exemple 7 : Compter et afficher le nombre d'élèves avec un niveau de natation supérieur ou égal à 10.
puts "Exemple 6"
natation = eleves.find_all{|eleve| eleve.natation.to_i >= 10}
puts "Natation >= 10 : #{natation.size}"

#Exercices
# a) Compter et afficher le nombre d'élèves dans le programe reg et anglais ELA
# b) Compter et afficher le nombre d'élèves dans le programe reg et anglais EESL
# c) Compter et afficher le nombre d'élèves dans le programe reg et anglais ESL
# d) Compter et afficher le nombre d'élèves dans le programe enr et anglais ELA
# e) Compter et afficher le nombre d'élèves dans le programe enr et anglais EESL
# f) Compter et afficher le nombre d'élèves dans le programe enr et anglais ESL

puts "Exercices"

f = File.open("eleves.html", "w")
html = "<htlm>"
	html << "<body>"
		html << "<table>"
			html << "<tr>"
			html << "<th>Numero</th>"
			html << "<th>Nom</th>"
			html << "<th>Prenom</th>"
			html << "<th>Sexe</th>"
			html << "<th>Programme</th>"
			html << "<th>Anglais</th>"
			html << "<th>Natation</th>"
			html << "</tr>"
			f.write(html + "\n")
			html = ""
			eleves.each do |eleve|
				html << "<tr>"
				html << "<td>#{eleve.numero}</td>"
				html << "<td>#{eleve.nom}</td>"
				html << "<td>#{eleve.prenom}</td>"
				html << "<td>#{eleve.sexe}</td>"
				html << "<td>#{eleve.programme}</td>"
				html << "<td>#{eleve.anglais}</td>"
				html << "<td>#{eleve.natation}</td>"
				html << "</tr>"
				f.write(html + "\n") 
			end	
		html = "</table>"
	html << "</body>"
html << "</html>"
f.write(html + "\n") 
f.close