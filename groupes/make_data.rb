f = File.open('data/real_s1.csv', "r:iso-8859-1:utf-8")
while ligne = f.gets
	#8724;Tang;Daniel;M;Enrichi;;EESL;
	# 0       1     2        3  4         5 6
	ligne = ligne.chomp
	#~ puts ligne
	
	infos = ligne.split(";")
	
	num = (infos[0].to_i + 123).to_s

	infos[0] = num
	puts infos.join(";")+";"
end
f.close