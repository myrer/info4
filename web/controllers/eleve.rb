def configurer_eleve_liste
	@eleves = Eleve.tous.sort {|a,b| a.nom+a.prenom <=> b.nom+b.prenom }
end

def configurer_eleve_importer(servlet_request)
	niveau = servlet_request.query['niveau'].downcase
	@rapport = Eleve.importer("assets/#{niveau}.csv")
end