def lire_fichier(nom_fichier)
	
	#Ouvrir le fichier en mode LECTURE : "r" pour read
	fichier = File.open(nom_fichier,"r")
	
	#Définir des variables pour calculer la moyenne plus tard.
	# moyenne = somme / nombre _elements
	somme = 0 
	nombre_elements = 0
	
	# gets fait la lecture d'une ligne du fichier.
	# Répétons ces commandes en boucle pendant 
	# qu'il y a des lignes dans le fichier à lire.
	while ligne = fichier.gets
		# Voici comment le fichier présente ses données :
		#Toronto;-19;15
		# ville; température; heure
		
		#La méthode split sépare un String en plusieurs éléments.
		#Ici, nous demandons à split de séparer les éléments 
		# à l'aide du point-virgule et de placer des données
		# dans les variables ville, temperature et heure.
		# Notez que chaque variable est un String.
		
		ville, temperature, heure = ligne.split(";")
		
		#Ces commande nous permettent d'isoler
		# une ville pour notre calcul.
		if ville == "Toronto" 
		then      
			# La méthode to_i transforme, si possible, un String
			# en Fixnum. C'est très utile!
			
			#Accumulons la somme des tempéatures pour calculer 
			#la moyenne.
			somme =  temperature.to_i + somme
			nombre_elements = nombre_elements + 1
		end
		
    end
	
	#Fermer le fichier
	fichier.close
	
	#Calculons la moyenne et affichons la.
	moyenne = somme/nombre_elements
	puts moyenne
end

#====MAIN
lire_fichier("temperature.csv")