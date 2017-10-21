rep = eleves.find_all{|eleve| eleve.programme == "reg" and eleve.anglais == "ELA"}
puts "reg, ELA  : #{rep.size}"

rep = eleves.find_all{|eleve| eleve.programme == "reg" and eleve.anglais == "EESL"}
puts "reg, EESL  : #{rep.size}"

rep = eleves.find_all{|eleve| eleve.programme == "reg" and eleve.anglais == "ESL"}
puts "reg, ESL  : #{rep.size}"

rep = eleves.find_all{|eleve| eleve.programme == "enr" and eleve.anglais == "ELA"}
puts "enr, ELA  : #{rep.size}"

rep = eleves.find_all{|eleve| eleve.programme == "enr" and eleve.anglais == "EESL"}
puts "enr, EESL  : #{rep.size}"

rep = eleves.find_all{|eleve| eleve.programme == "enr" and eleve.anglais == "ESL"}
puts "enr, ESL  : #{rep.size}"