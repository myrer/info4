def configurer_regle_afficher
	@regles = Regle.tous.sort {|a,b| a.niveau <=> b.niveau }
end

