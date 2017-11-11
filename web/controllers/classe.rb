def configurer_classe_index(servlet_request)
	@niveau = servlet_request.query['niveau']
	@classes = Classe.tous.select{|classe| classe.niveau == @niveau}.sort {|a,b| a.nom <=> b.nom }
end

