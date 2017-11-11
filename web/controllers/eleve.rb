def configurer_eleve_liste(servlet_request)
	@niveau = servlet_request.query['niveau']
	@eleves = Eleve.tous.select{|e| e.niveau == @niveau}.sort {|a,b| a.nom+a.prenom <=> b.nom+b.prenom }
end

def configurer_eleve_importer(servlet_request)
	niveau = servlet_request.query['niveau'].downcase
	@rapport = Eleve.importer("assets/#{niveau}.csv")
end