INSERT INTO csv_db.dog (`name`, color, gender, birthday, deathday, deathcause, breed, old_regnumber, new_regnumber, tatoo, chip, exportimport, breeding, health_eyes, health_dna, health_exam, health_testicles, id_mother, id_father) 
	VALUES ('Akia Tawy', 'vlkošedá', 'F', '2012-01-20 00:00:00.0', '2014-01-30 07:47:19.0', NULL, 'Československý vlčiak', 'ČMKÚ/ČSV/XXXX', 'SPKP 3212', NULL, 203098100229060, '2014-01-30 07:47:32.0', 'neuchovnený', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO csv_db.dog_photo (fileurl, id_dog, width, height) 
	VALUES ('http://csvproject.justm.sk/app/uploads/dog_photo/akiatawy-001.jpg', 1, 350, 350);
INSERT INTO csv_db.dog_photo (fileurl, id_dog, width, height) 
	VALUES ('http://csvproject.justm.sk/app/uploads/dog_photo/akiatawy-002.jpg', 1, 654, 390);