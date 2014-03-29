-- -----------------------------------------------------
-- Table `dog`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dog` (
    `id` INT(11) NOT NULL AUTO_INCREMENT ,
    `name` VARCHAR(100) NOT NULL,
    `color` ENUM('vlkošedá', 'vlkošedá sivá', 'vlkošedá tmavá', 'netypická') ,
    `gender` VARCHAR(1) NOT NULL, -- 1 character - M/F
    `birthday` DATETIME DEFAULT NULL, -- Pri krizencoch nie je presne znamy
    `deathday` DATETIME DEFAULT NULL, 
    `deathcause` VARCHAR(200) DEFAULT '', -- Príčina úmrtia 
    `breed` ENUM('Československý vlčiak', 'Karpatský vlk', 'Nemecký ovčiak', 'Kríženec F1', 'Kríženec F2', 'Kríženec F3', 'Kríženec F4', 'Kríženec F5', 'Neznámy pôvod', 'Kríženec viacerých druhov - overené oficiálnym DNA testom'),
    `old_regnumber` VARCHAR(20),
    `new_regnumber` VARCHAR(20),
    `tatoo` INT(4), -- 4 cisla zhodne s povodvny old_regnumber
    `chip` BIGINT, -- or VARCHAR(20)
    `exportimport` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- presny vyznam neznamy
    `breeding` ENUM('neuchovnený', 'chovný', 'nechovný', 'po chovnosti'),
    -- dalsie stlpce su lekarske zaznamy
    `health_eyes` VARCHAR(100), 
    `health_dna` VARCHAR(100),
    `health_exam` VARCHAR(200), -- ine lekarske testy
    `health_testicles` VARCHAR(100), -- semenníky
    `id_mother` INT, -- referencia na matku
    `id_father` INT, -- referencia na otca, ? neviem ci riesit takto alebo cez to krytie
    PRIMARY KEY (`id`) ,
    FOREIGN KEY (`id_mother`) REFERENCES `dog`(`id`) ON DELETE SET NULL ,
    FOREIGN KEY (`id_father`) REFERENCES `dog`(`id`) ON DELETE SET NULL )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `dog_photo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dog_photo` (
    `id` INT(11) NOT NULL AUTO_INCREMENT ,
    `fileurl` VARCHAR(300) NOT NULL,
	`width` INT,
	`height` INT,
    `id_dog` INT NOT NULL,
    PRIMARY KEY (`id`) ,
    FOREIGN KEY (`id_dog`) REFERENCES `dog`(`id`) ON DELETE CASCADE )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `health_dlk`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `health_dlk` (
    `id` INT(11) NOT NULL AUTO_INCREMENT ,
    `value` ENUM('0-0', '0-1', '1-1', '1-2', '2-2', '2-3', '3-3', '3-4', '4-4') NOT NULL,
    `doctorname` VARCHAR(50) NOT NULL,
    `date` DATETIME NOT NULL,
    `id_dog` INT NOT NULL,
    PRIMARY KEY (`id`) ,
    FOREIGN KEY (`id_dog`) REFERENCES `dog`(`id`) ON DELETE CASCADE )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `health_dbk`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `health_dbk` (
    `id` INT(11) NOT NULL AUTO_INCREMENT ,
    `value` ENUM('A/A', 'A/B', 'B/B', 'B/C', 'C/C', 'C/D', 'D/D', 'D/E', 'E/E') NOT NULL,
    `doctorname` VARCHAR(50) NOT NULL,
    `date` DATETIME NOT NULL,
    `id_dog` INT NOT NULL,
    PRIMARY KEY (`id`) ,
    FOREIGN KEY (`id_dog`) REFERENCES `dog`(`id`) ON DELETE CASCADE )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `health_dwarf`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `health_dwarf` (
    `id` INT(11) NOT NULL AUTO_INCREMENT ,
    `value` ENUM('N/N', 'N/DW', 'DW/DW') NOT NULL,
    `laboratoryname` VARCHAR(50) NOT NULL,
    `date` DATETIME NOT NULL,
    `id_dog` INT NOT NULL,
    PRIMARY KEY (`id`) ,
    FOREIGN KEY (`id_dog`) REFERENCES `dog`(`id`) ON DELETE CASCADE )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `health_dm`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `health_dm` (
    `id` INT(11) NOT NULL AUTO_INCREMENT ,
    `value` ENUM('N/N', 'N/DM', 'DM/DM') NOT NULL, 
    `laboratoryname` VARCHAR(50) NOT NULL,
    `date` DATETIME NOT NULL,
    `id_dog` INT NOT NULL,
    PRIMARY KEY (`id`) ,
    FOREIGN KEY (`id_dog`) REFERENCES `dog`(`id`) ON DELETE CASCADE )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `health_teeth` -- zdravie, zuby
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `health_teeth` (
    `id` INT(11) NOT NULL AUTO_INCREMENT ,
    `health_bite` ENUM ('nožnicový', 'kliešťový', 'podkus', 'predkus'), -- skus
    `health_teeth` ENUM('úplný', 'neúplný', 'neúplný-úraz'), -- chrup
    `comment` VARCHAR(200) NOT NULL,
    `urlattachment` VARCHAR(300), -- url adresa upload súboru s prílohou
    `id_dog` INT NOT NULL,
    PRIMARY KEY (`id`) ,
    FOREIGN KEY (`id_dog`) REFERENCES `dog`(`id`) ON DELETE CASCADE )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `role` -- Pouzivatelske role
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `role` (
    `id` INT(11) NOT NULL AUTO_INCREMENT ,
    `name` VARCHAR(30) NOT NULL, -- nazov role pouzivany v kode, kratke bez diakritiky pre minimalizovanie preklepov
    `realname` VARCHAR(30) NOT NULL, -- realny nazov pre potreby zobrazenie na stranke
    PRIMARY KEY (`id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
--  INSERT INTO role
-- -----------------------------------------------------
INSERT INTO `role` ( `name`, `realname` ) VALUES
    ( 'majitel', 'Majiteľ'),
    ( 'chovatel_svk', 'Chovateľ SVK'),
    ( 'chovatel_host', 'Chovateľ hosť'),
    ( 'vybor', 'Výbor'),
    ( 'admin', 'Administrator');

-- -----------------------------------------------------
-- Table `user` -- Pouzivatel
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `user` (
    `id` INT(11) NOT NULL AUTO_INCREMENT ,
    `name` VARCHAR(50) NOT NULL,
    `surname` VARCHAR(50) NOT NULL,
    `degree` VARCHAR(15) NOT NULL DEFAULT '', -- Akademicky titul, default prazdny String kedze aj tak pride z formulara, nech je zachovana integrita
    -- `username` VARCHAR(50) NOT NULL UNIQUE, -- pouzit na prihlasovanie?
    `email` VARCHAR(50) NOT NULL UNIQUE, 
    `passwordhash` VARCHAR(100) NOT NULL, 
    `webaddress` VARCHAR(300) , 
    `phone` VARCHAR(15) ,              
    `isactive` VARCHAR(15) , 
    `id_role` INT NOT NULL, 
    PRIMARY KEY (`id`),
    FOREIGN KEY (`id_role`) REFERENCES `role`(`id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `country` -- Krajina
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `country` (
    `id` INT(11) NOT NULL AUTO_INCREMENT ,
    `name` VARCHAR(50) NOT NULL ,
    PRIMARY KEY (`id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `user_address` -- Adresa pouzivatela
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `user_address` (
    `id` INT(11) NOT NULL AUTO_INCREMENT ,
    `street` VARCHAR(50) , -- NULLs allowed - nie vsetky obce majú ulice
    `housenumber` VARCHAR(50) NOT NULL ,
    `city` VARCHAR(50) NOT NULL ,
    `postcode` VARCHAR(6) NOT NULL ,
    `id_user` INT NOT NULL,
    `id_country` INT NOT NULL, 
    PRIMARY KEY (`id`),
    FOREIGN KEY (`id_user`) REFERENCES `user`(`id`) ON DELETE CASCADE, 
    FOREIGN KEY (`id_country`) REFERENCES `country`(`id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `kennel` -- Chovateľská stanica - je len rozšírením tabuľky user, 
--                                         aby bolo možné uvádzať z akej stanice pochádza pes, atď...
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kennel` (
    `id` INT(11) NOT NULL AUTO_INCREMENT ,
    `name` VARCHAR(50) NOT NULL,
    `id_user` INT NOT NULL,
    `isactive` INT(1) NOT NULL DEFAULT 1,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`id_user`) REFERENCES `user`(`id`) ON DELETE CASCADE )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
--  INSERT INTO ud_relation_state 
-- -----------------------------------------------------
INSERT INTO `ud_relation_state` ( `state` ) VALUES
    

-- -----------------------------------------------------
-- Table `user_dog_relation` -- Vzťah psa a používateľa 
--                                  - zohľadnňuje predošlé majiteľstvo a spolumajiteľstvo
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `user_dog_relation` (
    `id` INT(11) NOT NULL AUTO_INCREMENT ,
    `id_user` INT NOT NULL,
    `id_dog` INT NOT NULL,
    `state` ENUM ( 'majitel','spolumajiteľ', 'bývalý majiteľ' ), 
    PRIMARY KEY (`id`),
    FOREIGN KEY (`id_user`) REFERENCES `user`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`id_dog`) REFERENCES `dog`(`id`) ON DELETE CASCADE )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `lead_young`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lead_young`(  
	`id` INT(11) NOT NULL AUTO_INCREMENT ,
	`id_dog` INT,
    PRIMARY KEY (`id`) ,
    FOREIGN KEY (`id_dog`) REFERENCES `dog`(`id`) ON DELETE SET NULL
)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `lead_result`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lead_result` (
    `id` INT(11) NOT NULL AUTO_INCREMENT ,
    `mark` ENUM('nádejný', 'veľmi nádejný') ,
    PRIMARY KEY (`id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `lead_teeth`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lead_teeth` (
    `id` INT(11) NOT NULL AUTO_INCREMENT ,
    `value` ENUM(' zhryz ','plnochruposť ','chýba zub','zub navyše ','správna poloha zubov','nesprávna poloha zubov') ,
    `id_lead` INT,
	`id_result` INT,
	PRIMARY KEY (`id`) ,
    FOREIGN KEY (`id_lead`) REFERENCES `lead_young`(`id`) ON DELETE SET NULL ,
    FOREIGN KEY (`id_result`) REFERENCES `lead_result`(`id`) ON DELETE SET NULL  )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `lead_testicle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lead_testicle` (
    `id` INT(11) NOT NULL AUTO_INCREMENT ,
    `value` ENUM('chýba jedno ', 'chýbajú obe','nechýba žiadne') ,
	`id_lead` INT,
	`id_result` INT,
    PRIMARY KEY (`id`) ,
    FOREIGN KEY (`id_lead`) REFERENCES `lead_young`(`id`) ON DELETE SET NULL ,
    FOREIGN KEY (`id_result`) REFERENCES `lead_result`(`id`) ON DELETE SET NULL )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;
-- -----------------------------------------------------
-- Table `lead_nature`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lead_nature` (
    `id` INT(11) NOT NULL AUTO_INCREMENT ,
    `value` ENUM('melancholik - bojazlivý','neistý, nenadväzuje kontakt','dráždivý - neodvážny','dráždivý - nedôverčivý','cholerik, silne dráždivý','sangvinik - ovládatelný , vyrovnaný','sangvinik - menej odvážny','dobrácky - menej dráždivý','tažko vydrážditelny','flegmaticky - nevydrážditelný') ,
    `id_lead` INT,
	`id_result` INT,
	PRIMARY KEY (`id`) ,
    FOREIGN KEY (`id_lead`) REFERENCES `lead_young`(`id`) ON DELETE SET NULL ,
    FOREIGN KEY (`id_result`) REFERENCES `lead_result`(`id`) ON DELETE SET NULL  )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `lead_tap`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lead_tap` (
    `id` INT(11) NOT NULL AUTO_INCREMENT ,
    `value` INT(3),
	`id_lead` INT,
	`id_result` INT,	
	PRIMARY KEY (`id`) ,
    FOREIGN KEY (`id_lead`) REFERENCES `lead_young`(`id`) ON DELETE SET NULL ,
    FOREIGN KEY (`id_result`) REFERENCES `lead_result`(`id`) ON DELETE SET NULL )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `lead_step`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lead_step` (
    `id` INT(11) NOT NULL AUTO_INCREMENT ,
    `value` VARCHAR(70),
    `id_lead` INT,
	`id_result` INT,
	PRIMARY KEY (`id`) ,
    FOREIGN KEY (`id_lead`) REFERENCES `lead_young`(`id`) ON DELETE SET NULL ,
    FOREIGN KEY (`id_result`) REFERENCES `lead_result`(`id`) ON DELETE SET NULL )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `lead_trot`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lead_trot` (
    `id` INT(11) NOT NULL AUTO_INCREMENT ,
    `value` VARCHAR(70),
    `id_lead` INT,
	`id_result` INT,
	PRIMARY KEY (`id`) ,
    FOREIGN KEY (`id_lead`) REFERENCES `lead_young`(`id`) ON DELETE SET NULL ,
    FOREIGN KEY (`id_result`) REFERENCES `lead_result`(`id`) ON DELETE SET NULL )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;
-- -----------------------------------------------------
-- Table `bonitation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bonitation`(  
    `id` INT(11) NOT NULL AUTO_INCREMENT ,
    `id_dog` INT,
	PRIMARY KEY (`id`) ,
    FOREIGN KEY (`id_dog`) REFERENCES `dog`(`id`) ON DELETE SET NULL )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `bonitation_result`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bonitation_result` (
    `id` INT(11) NOT NULL AUTO_INCREMENT ,
    `mark` ENUM('1', '2', '3', '4','5') ,
    `defect` VARCHAR(3) NOT NULL, 
    `lack` VARCHAR(3) NOT NULL,
    PRIMARY KEY (`id`)  )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `bonitation_height`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bonitation_height` (
    `id` INT(11) NOT NULL AUTO_INCREMENT ,
    `value` ENUM('n pod 65 cm pod 60cm', 's 65-70 cm 60-65 cm', 'nad 70 cm nad 65 cm') ,
    `id_bonitation` INT,
	`id_result` INT,
	PRIMARY KEY (`id`) ,
    FOREIGN KEY (`id_bonitation`) REFERENCES `bonitation`(`id`) ON DELETE SET NULL ,
    FOREIGN KEY (`id_result`) REFERENCES `bonitation_result`(`id`) ON DELETE SET NULL )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `bonitation_testicle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bonitation_testicle` (
    `id` INT(11) NOT NULL AUTO_INCREMENT ,
    `value` ENUM('12 chýba jedno ', '14 chýbajú obe') ,
	`id_bonitation` INT,
	`id_result` INT,
    PRIMARY KEY (`id`) ,
    FOREIGN KEY (`id_bonitation`) REFERENCES `bonitation`(`id`) ON DELETE SET NULL ,
    FOREIGN KEY (`id_result`) REFERENCES `bonitation_result`(`id`) ON DELETE SET NULL )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `bonitation_teeth`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bonitation_teeth` (
    `id` INT(11) NOT NULL AUTO_INCREMENT ,
    `value` ENUM('3 psinkový','4 zhryz klieštovy','2 zub naviac','6 zhryz  -podhrýz','8 zhryz - predhryz ','12 neúplný (chýba 1 - 2 )','14 chýba viac ako 2') ,
    `id_bonitation` INT,
	`id_result` INT,
	PRIMARY KEY (`id`) ,
    FOREIGN KEY (`id_bonitation`) REFERENCES `bonitation`(`id`) ON DELETE SET NULL ,
    FOREIGN KEY (`id_result`) REFERENCES `bonitation_result`(`id`) ON DELETE SET NULL )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `bonitation_head`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bonitation_head` (
    `id` INT(11) NOT NULL AUTO_INCREMENT ,
    `value` ENUM('1 vrásky v kľude','3 ploché čelo','5 tažká hlava','7 ľahká hlava','2 dlhá hlava','4 krátka tlama','6 klabonos','8 prenesený nos','12 otvorené kútky','14 netypická') ,
    `id_bonitation` INT,
	`id_result` INT,
	PRIMARY KEY (`id`) ,
    FOREIGN KEY (`id_bonitation`) REFERENCES `bonitation`(`id`) ON DELETE SET NULL ,
    FOREIGN KEY (`id_result`) REFERENCES `bonitation_result`(`id`) ON DELETE SET NULL )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `bonitation_eyes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bonitation_eyes` (
    `id` INT(11) NOT NULL AUTO_INCREMENT ,
    `value` ENUM('1 svetlohnedé','3 tmavohnedé','5 čierne','7 rôzne sfarbené','8 guľaté ','10 hlboko uložené','12 vypuklé','14 netypické') ,
	`id_bonitation` INT,
	`id_result` INT,	
	PRIMARY KEY (`id`) ,
    FOREIGN KEY (`id_bonitation`) REFERENCES `bonitation`(`id`) ON DELETE SET NULL ,
    FOREIGN KEY (`id_result`) REFERENCES `bonitation_result`(`id`) ON DELETE SET NULL )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `bonitation_ears`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bonitation_ears` (
    `id` INT(11) NOT NULL AUTO_INCREMENT ,
    `value` ENUM('1 vysoko nasadené','5 nizko nasadené','7 hrubé','2 dlhé','4 mäkké','6 polo vzpriamené','8 dovnútra klopené','10 rozvesené','12 deformované','14 netypické') ,
    `id_bonitation` INT,
	`id_result` INT,
	PRIMARY KEY (`id`) ,
    FOREIGN KEY (`id_bonitation`) REFERENCES `bonitation`(`id`) ON DELETE SET NULL ,
    FOREIGN KEY (`id_result`) REFERENCES `bonitation_result`(`id`) ON DELETE SET NULL )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `bonitation_neck`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bonitation_neck` (
    `id` INT(11) NOT NULL AUTO_INCREMENT ,
    `value` ENUM('1 klenutý','3 vysoko nasadený','5 nizko nasadený','14 lalok') ,
    `id_bonitation` INT,
	`id_result` INT,
	PRIMARY KEY (`id`) ,
    FOREIGN KEY (`id_bonitation`) REFERENCES `bonitation`(`id`) ON DELETE SET NULL ,
    FOREIGN KEY (`id_result`) REFERENCES `bonitation_result`(`id`) ON DELETE SET NULL  )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `bonitation_hull`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bonitation_hull` (
    `id` INT(11) NOT NULL AUTO_INCREMENT ,
    `value` ENUM('1 nevýrazný kohútik','3 prehnutý chrbát','5 kaprí chrbát','7 dlhý zadok','2 široký hrudník','4 velké predhnutie','6 hlboký hrudník','8 sudkovitý hrudník','10 voľné brucho','12 velký sklon zadku','14 netypický') ,
    `id_bonitation` INT,
	`id_result` INT,
	PRIMARY KEY (`id`) ,
    FOREIGN KEY (`id_bonitation`) REFERENCES `bonitation`(`id`) ON DELETE SET NULL ,
    FOREIGN KEY (`id_result`) REFERENCES `bonitation_result`(`id`) ON DELETE SET NULL )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `bonitation_forelegs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bonitation_forelegs` (
    `id` INT(11) NOT NULL AUTO_INCREMENT ,
    `value` ENUM('5 nesprávne uhlené','7 mäkké nadprstie','2 široký postoj','4 vybočené lakte','6 netypická tlapa','8 krátke predprstie','10 krátke predlaktie','12 nesprávny postoj','14 netypické') ,
    `id_bonitation` INT,
	`id_result` INT,
	PRIMARY KEY (`id`) ,
    FOREIGN KEY (`id_bonitation`) REFERENCES `bonitation`(`id`) ON DELETE SET NULL ,
    FOREIGN KEY (`id_result`) REFERENCES `bonitation_result`(`id`) ON DELETE SET NULL )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `bonitation_hindquarters`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bonitation_hindquarters` (
    `id` INT(11) NOT NULL AUTO_INCREMENT ,
    `value` ENUM('3 nedostatočné osvalenie','5 preuhlené','7 málo uhlené','4 netypická tlapa','6 krátke stehno','8 krátke prekolenie','10 krátky priehlavok','12 nesprávny postoj','14 netypické') ,
    `id_bonitation` INT,
	`id_result` INT,
	PRIMARY KEY (`id`) ,
    FOREIGN KEY (`id_bonitation`) REFERENCES `bonitation`(`id`) ON DELETE SET NULL ,
    FOREIGN KEY (`id_result`) REFERENCES `bonitation_result`(`id`) ON DELETE SET NULL )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `bonitation_tail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bonitation_tail` (
    `id` INT(11) NOT NULL AUTO_INCREMENT ,
    `value` ENUM('1 dlhý','3 nízko nasadený','5 cadne nasadený','12 deformovaný','14 netypický') ,
    `id_bonitation` INT,
	`id_result` INT,
	PRIMARY KEY (`id`) ,
    FOREIGN KEY (`id_bonitation`) REFERENCES `bonitation`(`id`) ON DELETE SET NULL ,
    FOREIGN KEY (`id_result`) REFERENCES `bonitation_result`(`id`) ON DELETE SET NULL )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `bonitation_hair`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bonitation_hair` (
    `id` INT(11) NOT NULL AUTO_INCREMENT ,
    `value` ENUM('2 nedostatočne osrstenie','6 jemná','8 otvorená','14 netypická') ,
    `id_bonitation` INT,
	`id_result` INT,
	PRIMARY KEY (`id`) ,
    FOREIGN KEY (`id_bonitation`) REFERENCES `bonitation`(`id`) ON DELETE SET NULL ,
    FOREIGN KEY (`id_result`) REFERENCES `bonitation_result`(`id`) ON DELETE SET NULL )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `bonitation_color`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bonitation_color` (
    `id` INT(11) NOT NULL AUTO_INCREMENT ,
    `value` ENUM('3 tmavošedá','5 nevýrazná maska','2 bez masky','6 úbytok pigmentu','14 netypická') ,
    `id_bonitation` INT,
	`id_result` INT,
	PRIMARY KEY (`id`) ,
    FOREIGN KEY (`id_bonitation`) REFERENCES `bonitation`(`id`) ON DELETE SET NULL ,
    FOREIGN KEY (`id_result`) REFERENCES `bonitation_result`(`id`) ON DELETE SET NULL )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `bonitation_movement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bonitation_movement` (
    `id` INT(11) NOT NULL AUTO_INCREMENT ,
    `value` ENUM('3 krátky krok 8 šikmý pohyb','5 vlnitý pohyb 12 tažkopádny ','6 volné väzy 14 netypický') ,
    `id_bonitation` INT,
	`id_result` INT,
	PRIMARY KEY (`id`) ,
    FOREIGN KEY (`id_bonitation`) REFERENCES `bonitation`(`id`) ON DELETE SET NULL ,
    FOREIGN KEY (`id_result`) REFERENCES `bonitation_result`(`id`) ON DELETE SET NULL )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `bonitation_nature`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bonitation_nature` (
    `id` INT(11) NOT NULL AUTO_INCREMENT ,
    `value` ENUM('a melancholik - bojazlivý','b neistý, nenadväzuje kontakt','c dráždivý - neodvážny','d dráždivý - nedôverčivý','e cholerik, silne dráždivý','f sangvinik - ovládatelný , vyrovnaný','g sangvinik - menej odvážny','h dobrácky - menej dráždivý','i tažko vydrážditelny','f flegmaticky - nevydrážditelný ') ,
    `id_bonitation` INT,
	`id_result` INT,
	PRIMARY KEY (`id`) ,
    FOREIGN KEY (`id_bonitation`) REFERENCES `bonitation`(`id`) ON DELETE SET NULL ,
    FOREIGN KEY (`id_result`) REFERENCES `bonitation_result`(`id`) ON DELETE SET NULL  )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `bonitation_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bonitation_type` (
    `id` INT(11) NOT NULL AUTO_INCREMENT ,
    `value` ENUM('1 pevný 2 hrubý','3 jemný 4 lymfatický') ,
    `id_bonitation` INT,
	`id_result` INT,
	PRIMARY KEY (`id`) ,
    FOREIGN KEY (`id_bonitation`) REFERENCES `bonitation`(`id`) ON DELETE SET NULL ,
    FOREIGN KEY (`id_result`) REFERENCES `bonitation_result`(`id`) ON DELETE SET NULL  )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------   
-- Table `bonitation_standard` -- accordance with the standards
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bonitation_standard` (
    `id` INT(11) NOT NULL AUTO_INCREMENT ,
    `value` ENUM('1 výborný','5 dobrý','3 veľmi dobrý','14 nedostatočný') ,
    `id_bonitation` INT,
	`id_result` INT,
	PRIMARY KEY (`id`) ,
    FOREIGN KEY (`id_bonitation`) REFERENCES `bonitation`(`id`) ON DELETE SET NULL ,
    FOREIGN KEY (`id_result`) REFERENCES `bonitation_result`(`id`) ON DELETE SET NULL )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------- 
-- Table `bonitation_dimensions` -- physical dimensions
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bonitation_dimensions` (
    `id` INT(11) NOT NULL AUTO_INCREMENT ,
    `value` ENUM('výška v kohútiku','šikmá dlžka trupu','dlžka prednej nohy k laktu','dlžka nadprstia','obvod nadprsia','dlžka predkolenia','stehna','priehlavku','hlavy','tlamy','šírka hlavy','dlžka ucha','hlbka / širka hrudníka','obvod hrudníka','index výšky','index formátu') ,
    `id_bonitation` INT,
	`id_result` INT,
	PRIMARY KEY (`id`) ,
    FOREIGN KEY (`id_bonitation`) REFERENCES `bonitation`(`id`) ON DELETE SET NULL ,
    FOREIGN KEY (`id_result`) REFERENCES `bonitation_result`(`id`) ON DELETE SET NULL )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;
