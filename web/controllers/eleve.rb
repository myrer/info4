def configurer_eleve_liste
	@eleves = Eleve.tous.sort {|a,b| a.nom+a.prenom <=> b.nom+b.prenom }
end

