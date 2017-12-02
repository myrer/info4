def entete
	str = "<h1>Formation des groupes - JDLM 1.0</h1>"	
end

def barre_de_navigation
	str = %{<hr>\n}
	str << %{<nav>\n}
	str << %{<a href=/groupes/index.rhtml>Groupes</a>\n}
	str << %{<a href=/regles/index.rhtml>Règles</a>\n}
	str << %{<a href=/classes/index.rhtml>Classes</a>\n}
	str << %{<a href=/eleves/index.rhtml>Élèves</a>\n}
	str << %{Former : <a href=/groupes/former.rhtml?niveau=S1>S1</a>\n}
	str << %{<a href=/groupes/former.rhtml?niveau=S2>S2</a>\n}
	str << %{</nav>\n}
	str << %{<hr>\n}
	return str
end

def select_tag(params)
	str = "<select name=#{params[:name]}>\n"
	params[:options].each do |option|
		str << "<option value=#{option} "
		str << "#{"selected" if params[:selected] == option}>"
		str << "#{option}</option>\n"
	end
	str << "</select>\n"
end

def checkbox_tag(params)
	str = %{<fieldset>}
	params[:options].each do |option|
		str << %{<input type="checkbox" name="groupes[]" value="#{option}" id="#{option}" }
		str << %{#{"checked" if params[:checked].include?(option)} />\n}
		str << %{<label for="#{option}">#{option}</label>\n}
	end
	return str << "</fieldset>"
end