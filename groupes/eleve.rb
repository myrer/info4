# eleve.rb : Eleve est une représentation d'un élève de S1 à JDLM
class Eleve
	
	attr_reader :numero, :nom, :prenom, :sexe, :programme, :natation, :anglais, :groupe, :cours_ang
	
	def initialize(params) #params est un Hash qui contiendra les éléments requis pour construire un Eleve
		
		@numero = params[:numero]
		@nom = params[:nom]
		@prenom = params[:prenom]
		@sexe = params[:sexe]
		@programme = params[:programme]
		@natation = params[:natation]
		@anglais = params[:anglais]
		
		#configurer groupes_permis
		@groupes_permis = @@regles[@programme] & @@regles[@anglais] 
		
	end
	
	def to_s
		if @groupes_permis.empty? == true
		then groupes = "AUCUN!"
		else groupes = @groupes_permis.join(", ") 
		end
		
		if @groupe.nil?
		then 
			groupe = ""
			cours_ang = ""
		else
			groupe = @groupe
			cours_ang = @cours_ang	
		end	
		
		"#{@numero}\t#{@nom.ljust(20, " ")}#{@prenom.ljust(20, " ")}" + 
		"#{@sexe}\t#{@programme}\t#{@natation}\t#{@anglais.ljust(4, " ")}\t<#{groupe}> <#{cours_ang}>\t[#{groupes}]"
	end
	
	def assigner_groupe(gr)
		if  @groupes_permis.include?(gr)
		then 
			@groupe = gr
			assigner_cours_ang
		end
	end
	
	def assigner_groupe_au_hasard
		index = rand(@groupes_permis.size)
		@groupe = @groupes_permis[index]
		assigner_cours_ang
	end
	
	@@regles = {
		"enr" => ["102", "104", "106", "108"],
		"reg" => ["101", "103", "105", "107", "109", "110", "111"],
		
		"ELA" => ["101", "102", 							"107", "108"],
		"EESL" =>["101", "102", "103", "104", "105", "106", 			  "109", "110"],
		"ESL" => [              "103", "104", "105", "106", "107", "108", "109", "110", "111"]
	}
	
	@@cours_ang = {
		"101-ELA"  => "ELA104-00001",
		"101-EESL" => "EESL104-00001",
		"102-ELA"  => "ELA104-00001",
		"102-EESL" => "EESL104-00001",
		
		"103-EESL"=> "EESL104-00003", 
		"103-ESL"  => "ESL104-00003",
		"104-EESL" => "EESL104-00003", 
		"104-ESL"  => "ESL104-00003",
		
		"105-EESL"=> "EESL104-00005", 
		"105-ESL"  => "ESL104-00005",
		"106-EESL" => "EESL104-00005", 
		"106-ESL"  => "ESL104-00005",
		
		"107-ELA" => "ELA104-00007", 
		"107-ESL"  => "ESL104-00007",
		"108-ELA"  => "ELA104-00007", 
		"108-ESL"  => "ESL104-00007",
		
		"109-EESL"=> "EESL104-00009", 
		"109-ESL"  => "ESL104-00009",
		"110-EESL" => "EESL104-00009", 
		"110-ESL"  => "ESL104-00009",
		
		"111-ESL"  => "ESL104-00111"
	}
private
	def assigner_cours_ang
		@cours_ang = @@cours_ang[@groupe+"-"+@anglais]
	end
end

