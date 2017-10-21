class Regle
	attr_reader :niveau, :regles
	
	def initialize(params)
		@niveau = params[:niveau]
		configurer_regles(params[:fichier])
	end
	
	def to_s
		str = "#{@niveau}\n"
		regles.each{|attribut, groupes| str << "#{attribut}:#{groupes.join(";")}\n"}
		return str
	end

private
	def configurer_regles(fichier)
		@regles = Hash.new
		f = File.open(fichier, "r")
		while ligne = f.gets
			ligne = ligne.chomp
			attribut, groupes_str = ligne.split(":")
			groupes = groupes_str.split(";")
			@regles[attribut] = groupes
		end	
		f.close
		return @regles
	end	
end

regles_s1 = Regle.new({:niveau => 'S1', :fichier => "regles_s1.txt"})
puts regles_s1