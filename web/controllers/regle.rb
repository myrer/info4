def regles_index_controller(requete)
	case requete['ordre']
	when 'niveau'
		regles = Regle.tous.sort {|a,b| a.niveau+a.attribut <=> b.niveau+b.attribut}
	else
		regles = Regle.tous.sort {|a,b| a.attribut+a.niveau <=> b.attribut+b.niveau }
	end	
	return regles
end

