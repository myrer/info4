def configurer_regle_afficher(servlet_request)
	@niveau = servlet_request.query['niveau']
	@regles = Regle.tous.select{|regle| regle.niveau == @niveau}
end

