-- -----------------------------------------------------
-- Table `dog`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dog` (
    `dog__id` INT(11) NOT NULL AUTO_INCREMENT ,
    `dog__name` VARCHAR(100) NOT NULL,
    `dog__color` ENUM('vlkošedá', 'vlkošedá sivá', 'vlkošedá tmavá', 'netypická') ,
    `dog__gender` VARCHAR(1) NOT NULL, -- 1 character - M/F
    `dog__birthday` DATETIME DEFAULT NULL, -- Pri krizencoch nie je presne znamy
    `dog__deathday` DATETIME DEFAULT NULL, 
    `dog__deathcause` VARCHAR(200) DEFAULT '', -- Príčina úmrtia 
    `dog__breed` ENUM('Československý vlčiak', 'Karpatský vlk', 'Nemecký ovčiak', 'Kríženec F1', 'Kríženec F2', 'Kríženec F3', 'Kríženec F4', 'Kríženec F5', 'Neznámy pôvod', 'Kríženec viacerých druhov - overené oficiálnym DNA testom'),
    `dog__old_regnumber` VARCHAR(20),
    `dog__new_regnumber` VARCHAR(20),
    `dog__tatoo` INT(4), -- 4 cisla zhodne s povodvny dog__old_regnumber
    `dog__chip` BIGINT, -- or VARCHAR(20)
    `dog__exportimport` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- presny vyznam neznamy
    `dog__breeding` ENUM('neuchovnený', 'chovný', 'nechovný', 'po chovnosti'),
    -- dalsie stlpce su lekarske zaznamy
    `dog__health_eyes` VARCHAR(100), 
    `dog__health_dna` VARCHAR(100),
    `dog__health_exam` VARCHAR(200), -- ine lekarske testy
    `dog__health_testicles` VARCHAR(100), -- semenníky
    `dog__id_mother` INT, -- referencia na matku
    `dog__id_father` INT, -- referencia na otca, ? neviem ci riesit takto alebo cez to krytie
    PRIMARY KEY (`dog__id`) ,
    FOREIGN KEY (`dog__id_mother`) REFERENCES `dog`(`dog__id`) ON DELETE SET NULL ,
    FOREIGN KEY (`dog__id_father`) REFERENCES `dog`(`dog__id`) ON DELETE SET NULL )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `health_dlk`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `health_dlk` (
    `health_dlk__id` INT(11) NOT NULL AUTO_INCREMENT ,
    `health_dlk__value` ENUM('0-0', '0-1', '1-1', '1-2', '2-2', '2-3', '3-3', '3-4', '4-4') NOT NULL,
    `health_dlk__doctorname` VARCHAR(50) NOT NULL,
    `health_dlk__date` DATETIME NOT NULL,
    `health_dlk__id_dog` INT NOT NULL,
    PRIMARY KEY (`health_dlk__id`) ,
    FOREIGN KEY (`health_dlk__id_dog`) REFERENCES `dog`(`dog__id`) ON DELETE CASCADE )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `health_dbk`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `health_dbk` (
    `health_dbk__id` INT(11) NOT NULL AUTO_INCREMENT ,
    `health_dbk__value` ENUM('A/A', 'A/B', 'B/B', 'B/C', 'C/C', 'C/D', 'D/D', 'D/E', 'E/E') NOT NULL,
    `health_dbk__doctorname` VARCHAR(50) NOT NULL,
    `health_dbk__date` DATETIME NOT NULL,
    `health_dbk__id_dog` INT NOT NULL,
    PRIMARY KEY (`health_dbk__id`) ,
    FOREIGN KEY (`health_dbk__id_dog`) REFERENCES `dog`(`dog__id`) ON DELETE CASCADE )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `health_dwarf`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `health_dwarf` (
    `health_dwarf__id` INT(11) NOT NULL AUTO_INCREMENT ,
    `health_dwarf__value` ENUM('N/N', 'N/DW', 'DW/DW') NOT NULL,
    `health_dwarf__laboratoryname` VARCHAR(50) NOT NULL,
    `health_dwarf__date` DATETIME NOT NULL,
    `health_dwarf__id_dog` INT NOT NULL,
    PRIMARY KEY (`health_dwarf__id`) ,
    FOREIGN KEY (`health_dwarf__id_dog`) REFERENCES `dog`(`dog__id`) ON DELETE CASCADE )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `health_dm`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `health_dm` (
    `health_dm__id` INT(11) NOT NULL AUTO_INCREMENT ,
    `health_dm__value` ENUM('N/N', 'N/DM', 'DM/DM') NOT NULL, 
    `health_dm__laboratoryname` VARCHAR(50) NOT NULL,
    `health_dm__date` DATETIME NOT NULL,
    `health_dm__id_dog` INT NOT NULL,
    PRIMARY KEY (`health_dm__id`) ,
    FOREIGN KEY (`health_dm__id_dog`) REFERENCES `dog`(`dog__id`) ON DELETE CASCADE )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `health_teeth` -- zdravie, zuby
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `health_teeth` (
    `health_teeth__id` INT(11) NOT NULL AUTO_INCREMENT ,
    `health_teeth__health_bite` ENUM ('nožnicový', 'kliešťový', 'podkus', 'predkus'), -- skus
    `health_teeth__health_teeth` ENUM('úplný', 'neúplný', 'neúplný-úraz'), -- chrup
    `health_teeth__comment` VARCHAR(200) NOT NULL,
    `health_teeth__urlattachment` VARCHAR(300), -- url adresa upload súboru s prílohou
    `health_teeth__id_dog` INT NOT NULL,
    PRIMARY KEY (`health_teeth__id`) ,
    FOREIGN KEY (`health_teeth__id_dog`) REFERENCES `dog`(`dog__id`) ON DELETE CASCADE )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `role` -- Pouzivatelske role
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `role` (
    `role__id` INT(11) NOT NULL AUTO_INCREMENT ,
    `role__name` VARCHAR(30) NOT NULL, -- nazov role pouzivany v kode, kratke bez diakritiky pre minimalizovanie preklepov
    `role__realname` VARCHAR(30) NOT NULL, -- realny nazov pre potreby zobrazenie na stranke
    PRIMARY KEY (`role__id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
--  INSERT INTO role
-- -----------------------------------------------------
INSERT INTO `role` ( `role__name`, `role__realname` ) VALUES
    ( 'majitel', 'Majiteľ'),
    ( 'chovatel_svk', 'Chovateľ SVK'),
    ( 'chovatel_host', 'Chovateľ hosť'),
    ( 'vybor', 'Výbor'),
    ( 'admin', 'Administrator');

-- -----------------------------------------------------
-- Table `user` -- Pouzivatel
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `user` (
    `user__id` INT(11) NOT NULL AUTO_INCREMENT ,
    `user__name` VARCHAR(50) NOT NULL,
    `user__surname` VARCHAR(50) NOT NULL,
    `user__degree` VARCHAR(15) NOT NULL DEFAULT '', -- Akademicky titul, default prazdny String kedze aj tak pride z formulara, nech je zachovana integrita
    -- `user__username` VARCHAR(50) NOT NULL UNIQUE, -- pouzit na prihlasovanie?
    `user__email` VARCHAR(50) NOT NULL UNIQUE, 
    `user__passwordhash` VARCHAR(100) NOT NULL, 
    `user__webaddress` VARCHAR(300) , 
    `user__phone` VARCHAR(15) ,              
    `user__isactive` VARCHAR(15) , 
    `user__id_role` INT NOT NULL, 
    PRIMARY KEY (`user__id`),
    FOREIGN KEY (`user__id_role`) REFERENCES `role`(`role__id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `country` -- Krajina
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `country` (
    `country__id` INT(11) NOT NULL AUTO_INCREMENT ,
    `country__name` VARCHAR(50) NOT NULL ,
    PRIMARY KEY (`country__id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `user_address` -- Adresa pouzivatela
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `user_address` (
    `user_address__id` INT(11) NOT NULL AUTO_INCREMENT ,
    `user_address__street` VARCHAR(50) , -- NULLs allowed - nie vsetky obce majú ulice
    `user_address__housenumber` VARCHAR(50) NOT NULL ,
    `user_address__city` VARCHAR(50) NOT NULL ,
    `user_address__postcode` VARCHAR(6) NOT NULL ,
    `user_address__id_user` INT NOT NULL,
    `user_address__id_country` INT NOT NULL, 
    PRIMARY KEY (`user_address__id`),
    FOREIGN KEY (`user_address__id_user`) REFERENCES `user`(`user__id`) ON DELETE CASCADE, 
    FOREIGN KEY (`user_address__id_country`) REFERENCES `country`(`country__id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `kennel` -- Chovateľská stanica - je len rozšírením tabuľky user, 
--                                         aby bolo možné uvádzať z akej stanice pochádza pes, atď...
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kennel` (
    `kennel__id` INT(11) NOT NULL AUTO_INCREMENT ,
    `kennel__name` VARCHAR(50) NOT NULL,
    `kennel__id_user` INT NOT NULL,
    `kennel__isactive` INT(1) NOT NULL DEFAULT 1,
    PRIMARY KEY (`kennel__id`),
    FOREIGN KEY (`kennel__id_user`) REFERENCES `user`(`user__id`) ON DELETE CASCADE )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;
   

-- -----------------------------------------------------
-- Table `user_dog_relation` -- Vzťah psa a používateľa 
--                                  - zohľadnňuje predošlé majiteľstvo a spolumajiteľstvo
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `user_dog_relation` (
    `user_dog_relation__id` INT(11) NOT NULL AUTO_INCREMENT ,
    `user_dog_relation__id_user` INT NOT NULL,
    `user_dog_relation__id_dog` INT NOT NULL,
    `user_dog_relation__state` ENUM ( 'majitel','spolumajiteľ', 'bývalý majiteľ' ), 
    PRIMARY KEY (`user_dog_relation__id`),
    FOREIGN KEY (`user_dog_relation__id_user`) REFERENCES `user`(`user__id`) ON DELETE CASCADE,
    FOREIGN KEY (`user_dog_relation__id_dog`) REFERENCES `dog`(`dog__id`) ON DELETE CASCADE )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `lead_young`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lead_young`(  
	`lead_young__id` INT(11) NOT NULL AUTO_INCREMENT ,
	`lead_young__id_dog` INT,
    PRIMARY KEY (`lead_young__id`) ,
    FOREIGN KEY (`lead_young__id_dog`) REFERENCES `dog`(`dog__id`) ON DELETE SET NULL
)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `lead_result`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lead_result` (
    `lead_result__id` INT(11) NOT NULL AUTO_INCREMENT ,
    `lead_result__mark` ENUM('nádejný', 'veľmi nádejný') ,
    PRIMARY KEY (`lead_result__id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `lead_teeth`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lead_teeth` (
    `lead_teeth__id` INT(11) NOT NULL AUTO_INCREMENT ,
    `lead_teeth__value` ENUM(' zhryz ','plnochruposť ','chýba zub','zub navyše ','správna poloha zubov','nesprávna poloha zubov') ,
    `lead_teeth__id_lead` INT,
	`lead_teeth__id_result` INT,
	PRIMARY KEY (`lead_teeth__id`) ,
    FOREIGN KEY (`lead_teeth__id_lead`) REFERENCES `lead_young`(`lead_young__id`) ON DELETE SET NULL ,
    FOREIGN KEY (`lead_teeth__id_result`) REFERENCES `lead_result`(`lead_result__id`) ON DELETE SET NULL  )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `lead_testicle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lead_testicle` (
    `lead_testicle__id` INT(11) NOT NULL AUTO_INCREMENT ,
    `lead_testicle__value` ENUM('chýba jedno ', 'chýbajú obe','nechýba žiadne') ,
	`lead_testicle__id_lead` INT,
	`lead_testicle__id_result` INT,
    PRIMARY KEY (`lead_testicle__id`) ,
    FOREIGN KEY (`lead_testicle__id_lead`) REFERENCES `lead_young`(`lead_young__id`) ON DELETE SET NULL ,
    FOREIGN KEY (`lead_testicle__id_result`) REFERENCES `lead_result`(`lead_result__id`) ON DELETE SET NULL )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;
-- -----------------------------------------------------
-- Table `lead_nature`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lead_nature` (
    `lead_nature__id` INT(11) NOT NULL AUTO_INCREMENT ,
    `lead_nature__value` ENUM('melancholik - bojazlivý','neistý, nenadväzuje kontakt','dráždivý - neodvážny','dráždivý - nedôverčivý','cholerik, silne dráždivý','sangvinik - ovládatelný , vyrovnaný','sangvinik - menej odvážny','dobrácky - menej dráždivý','tažko vydrážditelny','flegmaticky - nevydrážditelný') ,
    `lead_nature__id_lead` INT,
	`lead_nature__id_result` INT,
	PRIMARY KEY (`lead_nature__id`) ,
    FOREIGN KEY (`lead_nature__id_lead`) REFERENCES `lead_young`(`lead_young__id`) ON DELETE SET NULL ,
    FOREIGN KEY (`lead_nature__id_result`) REFERENCES `lead_result`(`lead_result__id`) ON DELETE SET NULL  )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `lead_tap`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lead_tap` (
    `lead_tap__id` INT(11) NOT NULL AUTO_INCREMENT ,
    `lead_tap__value` INT(3),
	`lead_tap__id_lead` INT,
	`lead_tap__id_result` INT,	
	PRIMARY KEY (`lead_tap__id`) ,
    FOREIGN KEY (`lead_tap__id_lead`) REFERENCES `lead_young`(`lead_young__id`) ON DELETE SET NULL ,
    FOREIGN KEY (`lead_tap__id_result`) REFERENCES `lead_result`(`lead_result__id`) ON DELETE SET NULL )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `lead_step`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lead_step` (
    `lead_step__id` INT(11) NOT NULL AUTO_INCREMENT ,
    `lead_step__value` VARCHAR(70),
    `lead_step__id_lead` INT,
	`lead_step__id_result` INT,
	PRIMARY KEY (`lead_step__id`) ,
    FOREIGN KEY (`lead_step__id_lead`) REFERENCES `lead_young`(`lead_young__id`) ON DELETE SET NULL ,
    FOREIGN KEY (`lead_step__id_result`) REFERENCES `lead_result`(`lead_result__id`) ON DELETE SET NULL )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `lead_trot`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lead_trot` (
    `lead_trot__id` INT(11) NOT NULL AUTO_INCREMENT ,
    `lead_trot__value` VARCHAR(70),
    `lead_trot__id_lead` INT,
	`lead_trot__id_result` INT,
	PRIMARY KEY (`lead_trot__id`) ,
    FOREIGN KEY (`lead_trot__id_lead`) REFERENCES `lead_young`(`lead_young__id`) ON DELETE SET NULL ,
    FOREIGN KEY (`lead_trot__id_result`) REFERENCES `lead_result`(`lead_result__id`) ON DELETE SET NULL )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;
-- -----------------------------------------------------
-- Table `bonitation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bonitation`(  
    `bonitation__id` INT(11) NOT NULL AUTO_INCREMENT ,
    `bonitation__id_dog` INT,
	PRIMARY KEY (`bonitation__id`) ,
    FOREIGN KEY (`bonitation__id_dog`) REFERENCES `dog`(`dog__id`) ON DELETE SET NULL )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `bonitation_result`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bonitation_result` (
    `bonitation_result__id` INT(11) NOT NULL AUTO_INCREMENT ,
    `bonitation_result__mark` ENUM('1', '2', '3', '4','5') ,
    `bonitation_result__defect` VARCHAR(3) NOT NULL, 
    `bonitation_result__lack` VARCHAR(3) NOT NULL,
    PRIMARY KEY (`bonitation_result__id`)  )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `bonitation_height`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bonitation_height` (
    `bonitation_height__id` INT(11) NOT NULL AUTO_INCREMENT ,
    `bonitation_height__value` ENUM('n pod 65 cm pod 60cm', 's 65-70 cm 60-65 cm', 'nad 70 cm nad 65 cm') ,
    `bonitation_height__id_bonitation` INT,
	`bonitation_height__id_result` INT,
	PRIMARY KEY (`bonitation_height__id`) ,
    FOREIGN KEY (`bonitation_height__id_bonitation`) REFERENCES `bonitation`(`bonitation__id`) ON DELETE SET NULL ,
    FOREIGN KEY (`bonitation_height__id_result`) REFERENCES `bonitation_result`(`bonitation_result__id`) ON DELETE SET NULL )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `bonitation_testicle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bonitation_testicle` (
    `bonitation_testicle__id` INT(11) NOT NULL AUTO_INCREMENT ,
    `bonitation_testicle__value` ENUM('12 chýba jedno ', '14 chýbajú obe') ,
	`bonitation_testicle__id_bonitation` INT,
	`bonitation_testicle__id_result` INT,
    PRIMARY KEY (`bonitation_testicle__id`) ,
    FOREIGN KEY (`bonitation_testicle__id_bonitation`) REFERENCES `bonitation`(`bonitation__id`) ON DELETE SET NULL ,
    FOREIGN KEY (`bonitation_testicle__id_result`) REFERENCES `bonitation_result`(`bonitation_result__id`) ON DELETE SET NULL )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `bonitation_teeth`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bonitation_teeth` (
    `bonitation_teeth__id` INT(11) NOT NULL AUTO_INCREMENT ,
    `bonitation_teeth__value` ENUM('3 psinkový','4 zhryz klieštovy','2 zub naviac','6 zhryz  -podhrýz','8 zhryz - predhryz ','12 neúplný (chýba 1 - 2 )','14 chýba viac ako 2') ,
    `bonitation_teeth__id_bonitation` INT,
	`bonitation_teeth__id_result` INT,
	PRIMARY KEY (`bonitation_teeth__id`) ,
    FOREIGN KEY (`bonitation_teeth__id_bonitation`) REFERENCES `bonitation`(`bonitation__id`) ON DELETE SET NULL ,
    FOREIGN KEY (`bonitation_teeth__id_result`) REFERENCES `bonitation_result`(`bonitation_result__id`) ON DELETE SET NULL )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `bonitation_head`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bonitation_head` (
    `bonitation_head__id` INT(11) NOT NULL AUTO_INCREMENT ,
    `bonitation_head__value` ENUM('1 vrásky v kľude','3 ploché čelo','5 tažká hlava','7 ľahká hlava','2 dlhá hlava','4 krátka tlama','6 klabonos','8 prenesený nos','12 otvorené kútky','14 netypická') ,
    `bonitation_head__id_bonitation` INT,
	`bonitation_head__id_result` INT,
	PRIMARY KEY (`bonitation_head__id`) ,
    FOREIGN KEY (`bonitation_head__id_bonitation`) REFERENCES `bonitation`(`bonitation__id`) ON DELETE SET NULL ,
    FOREIGN KEY (`bonitation_head__id_result`) REFERENCES `bonitation_result`(`bonitation_result__id`) ON DELETE SET NULL )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `bonitation_eyes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bonitation_eyes` (
    `bonitation_eyes__id` INT(11) NOT NULL AUTO_INCREMENT ,
    `bonitation_eyes__value` ENUM('1 svetlohnedé','3 tmavohnedé','5 čierne','7 rôzne sfarbené','8 guľaté ','10 hlboko uložené','12 vypuklé','14 netypické') ,
	`bonitation_eyes__id_bonitation` INT,
	`bonitation_eyes__id_result` INT,	
	PRIMARY KEY (`bonitation_eyes__id`) ,
    FOREIGN KEY (`bonitation_eyes__id_bonitation`) REFERENCES `bonitation`(`bonitation__id`) ON DELETE SET NULL ,
    FOREIGN KEY (`bonitation_eyes__id_result`) REFERENCES `bonitation_result`(`bonitation_result__id`) ON DELETE SET NULL )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `bonitation_ears`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bonitation_ears` (
    `bonitation_ears__id` INT(11) NOT NULL AUTO_INCREMENT ,
    `bonitation_ears__value` ENUM('1 vysoko nasadené','5 nizko nasadené','7 hrubé','2 dlhé','4 mäkké','6 polo vzpriamené','8 dovnútra klopené','10 rozvesené','12 deformované','14 netypické') ,
    `bonitation_ears__id_bonitation` INT,
	`bonitation_ears__id_result` INT,
	PRIMARY KEY (`bonitation_ears__id`) ,
    FOREIGN KEY (`bonitation_ears__id_bonitation`) REFERENCES `bonitation`(`bonitation__id`) ON DELETE SET NULL ,
    FOREIGN KEY (`bonitation_ears__id_result`) REFERENCES `bonitation_result`(`bonitation_result__id`) ON DELETE SET NULL )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `bonitation_neck`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bonitation_neck` (
    `bonitation_neck__id` INT(11) NOT NULL AUTO_INCREMENT ,
    `bonitation_neck__value` ENUM('1 klenutý','3 vysoko nasadený','5 nizko nasadený','14 lalok') ,
    `bonitation_neck__id_bonitation` INT,
	`bonitation_neck__id_result` INT,
	PRIMARY KEY (`bonitation_neck__id`) ,
    FOREIGN KEY (`bonitation_neck__id_bonitation`) REFERENCES `bonitation`(`bonitation__id`) ON DELETE SET NULL ,
    FOREIGN KEY (`bonitation_neck__id_result`) REFERENCES `bonitation_result`(`bonitation_result__id`) ON DELETE SET NULL  )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `bonitation_hull`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bonitation_hull` (
    `bonitation_hull__id` INT(11) NOT NULL AUTO_INCREMENT ,
    `bonitation_hull__value` ENUM('1 nevýrazný kohútik','3 prehnutý chrbát','5 kaprí chrbát','7 dlhý zadok','2 široký hrudník','4 velké predhnutie','6 hlboký hrudník','8 sudkovitý hrudník','10 voľné brucho','12 velký sklon zadku','14 netypický') ,
    `bonitation_hull__id_bonitation` INT,
	`bonitation_hull__id_result` INT,
	PRIMARY KEY (`bonitation_hull__id`) ,
    FOREIGN KEY (`bonitation_hull__id_bonitation`) REFERENCES `bonitation`(`bonitation__id`) ON DELETE SET NULL ,
    FOREIGN KEY (`bonitation_hull__id_result`) REFERENCES `bonitation_result`(`bonitation_result__id`) ON DELETE SET NULL )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `bonitation_forelegs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bonitation_forelegs` (
    `bonitation_forelegs__id` INT(11) NOT NULL AUTO_INCREMENT ,
    `bonitation_forelegs__value` ENUM('5 nesprávne uhlené','7 mäkké nadprstie','2 široký postoj','4 vybočené lakte','6 netypická tlapa','8 krátke predprstie','10 krátke predlaktie','12 nesprávny postoj','14 netypické') ,
    `bonitation_forelegs__id_bonitation` INT,
	`bonitation_forelegs__id_result` INT,
	PRIMARY KEY (`bonitation_forelegs__id`) ,
    FOREIGN KEY (`bonitation_forelegs__id_bonitation`) REFERENCES `bonitation`(`bonitation__id`) ON DELETE SET NULL ,
    FOREIGN KEY (`bonitation_forelegs__id_result`) REFERENCES `bonitation_result`(`bonitation_result__id`) ON DELETE SET NULL )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `bonitation_hindquarters`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bonitation_hindquarters` (
    `bonitation_hindquarters__id` INT(11) NOT NULL AUTO_INCREMENT ,
    `bonitation_hindquarters__value` ENUM('3 nedostatočné osvalenie','5 preuhlené','7 málo uhlené','4 netypická tlapa','6 krátke stehno','8 krátke prekolenie','10 krátky priehlavok','12 nesprávny postoj','14 netypické') ,
    `bonitation_hindquarters__id_bonitation` INT,
	`bonitation_hindquarters__id_result` INT,
	PRIMARY KEY (`bonitation_hindquarters__id`) ,
    FOREIGN KEY (`bonitation_hindquarters__id_bonitation`) REFERENCES `bonitation`(`bonitation__id`) ON DELETE SET NULL ,
    FOREIGN KEY (`bonitation_hindquarters__id_result`) REFERENCES `bonitation_result`(`bonitation_result__id`) ON DELETE SET NULL )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `bonitation_tail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bonitation_tail` (
    `bonitation_tail__id` INT(11) NOT NULL AUTO_INCREMENT ,
    `bonitation_tail__value` ENUM('1 dlhý','3 nízko nasadený','5 cadne nasadený','12 deformovaný','14 netypický') ,
    `bonitation_tail__id_bonitation` INT,
	`bonitation_tail__id_result` INT,
	PRIMARY KEY (`bonitation_tail__id`) ,
    FOREIGN KEY (`bonitation_tail__id_bonitation`) REFERENCES `bonitation`(`bonitation__id`) ON DELETE SET NULL ,
    FOREIGN KEY (`bonitation_tail__id_result`) REFERENCES `bonitation_result`(`bonitation_result__id`) ON DELETE SET NULL )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `bonitation_hair`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bonitation_hair` (
    `bonitation_hair__id` INT(11) NOT NULL AUTO_INCREMENT ,
    `bonitation_hair__value` ENUM('2 nedostatočne osrstenie','6 jemná','8 otvorená','14 netypická') ,
    `bonitation_hair__id_bonitation` INT,
	`bonitation_hair__id_result` INT,
	PRIMARY KEY (`bonitation_hair__id`) ,
    FOREIGN KEY (`bonitation_hair__id_bonitation`) REFERENCES `bonitation`(`bonitation__id`) ON DELETE SET NULL ,
    FOREIGN KEY (`bonitation_hair__id_result`) REFERENCES `bonitation_result`(`bonitation_result__id`) ON DELETE SET NULL )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `bonitation_color`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bonitation_color` (
    `bonitation_color__id` INT(11) NOT NULL AUTO_INCREMENT ,
    `bonitation_color__value` ENUM('3 tmavošedá','5 nevýrazná maska','2 bez masky','6 úbytok pigmentu','14 netypická') ,
    `bonitation_color__id_bonitation` INT,
	`bonitation_color__id_result` INT,
	PRIMARY KEY (`bonitation_color__id`) ,
    FOREIGN KEY (`bonitation_color__id_bonitation`) REFERENCES `bonitation`(`bonitation__id`) ON DELETE SET NULL ,
    FOREIGN KEY (`bonitation_color__id_result`) REFERENCES `bonitation_result`(`bonitation_result__id`) ON DELETE SET NULL )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `bonitation_movement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bonitation_movement` (
    `bonitation_movement__id` INT(11) NOT NULL AUTO_INCREMENT ,
    `bonitation_movement__value` ENUM('3 krátky krok 8 šikmý pohyb','5 vlnitý pohyb 12 tažkopádny ','6 volné väzy 14 netypický') ,
    `bonitation_movement__id_bonitation` INT,
	`bonitation_movement__id_result` INT,
	PRIMARY KEY (`bonitation_movement__id`) ,
    FOREIGN KEY (`bonitation_movement__id_bonitation`) REFERENCES `bonitation`(`bonitation__id`) ON DELETE SET NULL ,
    FOREIGN KEY (`bonitation_movement__id_result`) REFERENCES `bonitation_result`(`bonitation_result__id`) ON DELETE SET NULL )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `bonitation_nature`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bonitation_nature` (
    `bonitation_nature__id` INT(11) NOT NULL AUTO_INCREMENT ,
    `bonitation_nature__value` ENUM('a melancholik - bojazlivý','b neistý, nenadväzuje kontakt','c dráždivý - neodvážny','d dráždivý - nedôverčivý','e cholerik, silne dráždivý','f sangvinik - ovládatelný , vyrovnaný','g sangvinik - menej odvážny','h dobrácky - menej dráždivý','i tažko vydrážditelny','f flegmaticky - nevydrážditelný ') ,
    `bonitation_nature__id_bonitation` INT,
	`bonitation_nature__id_result` INT,
	PRIMARY KEY (`bonitation_nature__id`) ,
    FOREIGN KEY (`bonitation_nature__id_bonitation`) REFERENCES `bonitation`(`bonitation__id`) ON DELETE SET NULL ,
    FOREIGN KEY (`bonitation_nature__id_result`) REFERENCES `bonitation_result`(`bonitation_result__id`) ON DELETE SET NULL  )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `bonitation_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bonitation_type` (
    `bonitation_type__id` INT(11) NOT NULL AUTO_INCREMENT ,
    `bonitation_type__value` ENUM('1 pevný 2 hrubý','3 jemný 4 lymfatický') ,
    `bonitation_type__id_bonitation` INT,
	`bonitation_type__id_result` INT,
	PRIMARY KEY (`bonitation_type__id`) ,
    FOREIGN KEY (`bonitation_type__id_bonitation`) REFERENCES `bonitation`(`bonitation__id`) ON DELETE SET NULL ,
    FOREIGN KEY (`bonitation_type__id_result`) REFERENCES `bonitation_result`(`bonitation_result__id`) ON DELETE SET NULL  )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------   
-- Table `bonitation_standard` -- accordance with the standards
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bonitation_standard` (
    `bonitation_standard__id` INT(11) NOT NULL AUTO_INCREMENT ,
    `bonitation_standard__value` ENUM('1 výborný','5 dobrý','3 veľmi dobrý','14 nedostatočný') ,
    `bonitation_standard__id_bonitation` INT,
	`bonitation_standard__id_result` INT,
	PRIMARY KEY (`bonitation_standard__id`) ,
    FOREIGN KEY (`bonitation_standard__id_bonitation`) REFERENCES `bonitation`(`bonitation__id`) ON DELETE SET NULL ,
    FOREIGN KEY (`bonitation_standard__id_result`) REFERENCES `bonitation_result`(`bonitation_result__id`) ON DELETE SET NULL )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------- 
-- Table `bonitation_dimensions` -- physical dimensions
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bonitation_dimensions` (
    `bonitation_dimensions__id` INT(11) NOT NULL AUTO_INCREMENT ,
    `bonitation_dimensions__value` ENUM('výška v kohútiku','šikmá dlžka trupu','dlžka prednej nohy k laktu','dlžka nadprstia','obvod nadprsia','dlžka predkolenia','stehna','priehlavku','hlavy','tlamy','šírka hlavy','dlžka ucha','hlbka / širka hrudníka','obvod hrudníka','index výšky','index formátu') ,
    `bonitation_dimensions__id_bonitation` INT,
	`bonitation_dimensions__id_result` INT,
	PRIMARY KEY (`bonitation_dimensions__id`) ,
    FOREIGN KEY (`bonitation_dimensions__id_bonitation`) REFERENCES `bonitation`(`bonitation__id`) ON DELETE SET NULL ,
    FOREIGN KEY (`bonitation_dimensions__id_result`) REFERENCES `bonitation_result`(`bonitation_result__id`) ON DELETE SET NULL )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;





