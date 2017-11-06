f = File.open("assets/OLD_s1.csv", "r")
while ligne = f.gets
	ligne = ligne.chomp
	infos = ligne.split(";")
	
	numero = infos[0]
	nom = infos[1]
	prenom = infos[2]
	sexe = infos[3]
	programme = infos[4]
	natation = infos[5]
	anglais = infos[6]
	#~ musique => infos[7]
	puts "#{numero};S1;#{nom};#{prenom};#{sexe};#{natation};#{programme};#{anglais};"
end
f.close
