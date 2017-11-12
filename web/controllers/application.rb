Niveaux = %w[S1 S2 S3 S4 S5]

def ouverture
	str = "<html>"
	str << "<head> <meta charset='UTF-8'>	</head>"
	str << "<body>"
	str << render("views/entete.html")
end

def fermeture
	"</body></html>"
end

def render(file_name)
	f = File.open(file_name, "r")
	str = ""
	while line = f.gets
		str << line
	end
	f.close
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
	puts params
	#<input type="checkbox" name="ens_cb[]" value="153" checked />
	str = %{<fieldset>}
	params[:options].each do |option|
		str << %{<input type="checkbox" name="groupes[]" value="#{option}" id="#{option}" }
		str << %{#{"checked" if params[:checked].include?(option)} />\n}
		str << %{<label for="#{option}">#{option}</label>\n}
	end
	return str << "</fieldset>"
end