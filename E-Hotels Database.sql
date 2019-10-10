DROP SCHEMA IF EXISTS `hotel_db` ;

CREATE SCHEMA `hotel_db` ;

CREATE TABLE `hotel_db`.`employee` (
  `IRS_Number` VARCHAR(45) NOT NULL,
  `Last_Name` VARCHAR(45) NULL,
  `First_Name` VARCHAR(45) NULL,
  `Social_Security_Number` VARCHAR(45) NULL,
  `Street` VARCHAR(45) NULL,
  `Number` VARCHAR(45) NULL,
  `Postal_Code` INT NULL,
  `City` VARCHAR(45) NULL,
  PRIMARY KEY (`IRS_Number`));
  
  CREATE TABLE `hotel_db`.`hotel_group` (
  `Hotel_group_ID` INT NOT NULL,
  `hotelgroup_name` VARCHAR(45) NULL,
  `Street` VARCHAR(45) NULL,
  `Number` VARCHAR(45) NULL,
  `Postal_Code` INT NULL,
  `City_group` VARCHAR(45) NULL,
  `Number_of_hotels` INT NULL,
  PRIMARY KEY (`Hotel_group_ID`));
  
  CREATE TABLE `hotel_db`.`hotel` (
  `hotel_ID` INT NOT NULL,
  `hotel_name` VARCHAR(45) NULL,
  `Street` VARCHAR(45) NULL,
  `Number` VARCHAR(45) NULL,
  `Postal_Code` INT NULL,
  `City` VARCHAR(45) NULL,
  `Stars` INT NULL,
  `Number_of_rooms` INT NULL,
  `Hotelgroup_ID` INT NOT NULL,
  CONSTRAINT hotels UNIQUE (`hotel_name`),
  PRIMARY KEY (`hotel_ID`),
  CONSTRAINT `FK_HotelgroupID`
	FOREIGN KEY (`Hotelgroup_ID`)
    REFERENCES `hotel_db`.`hotel_group`(`Hotel_group_ID`)
	ON DELETE CASCADE
    ON UPDATE CASCADE);
  
  CREATE TABLE `hotel_db`.`email_hotel` (
  `Hotel_ID` INT NOT NULL,
  `Email_Address` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Hotel_ID`, `Email_Address`),
  CONSTRAINT `Hotel_ID4`
  FOREIGN KEY (`Hotel_ID`)
  REFERENCES `hotel_db`.`hotel` (`hotel_ID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE);
  
  CREATE TABLE `hotel_db`.`phone_hotel` (
  `Hotel_ID` INT NOT NULL,
  `Phone_number` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Hotel_ID`, `Phone_number`),
  CONSTRAINT `Hotel_ID5`
  FOREIGN KEY (`Hotel_ID`)
  REFERENCES `hotel_db`.`hotel` (`hotel_ID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE);

CREATE TABLE `hotel_db`.`email_hotel_group` (
  `Hotel_group_ID` INT NOT NULL,
  `Email_Address` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Hotel_group_ID`, `Email_Address`),
  CONSTRAINT `Hotel_group_ID`
  FOREIGN KEY (`Hotel_group_ID`)
  REFERENCES `hotel_db`.`hotel_group` (`Hotel_group_ID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE);
  
  CREATE TABLE `hotel_db`.`phone_hotel_group` (
  `Hotel_group_ID` INT NOT NULL,
  `Phone_number` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Hotel_group_ID`, `Phone_number`),
   CONSTRAINT `FK_phone_hotel_group`
	FOREIGN KEY (`Hotel_group_ID`)
    REFERENCES `hotel_db`.`hotel_group`(`Hotel_group_ID`)
	ON DELETE CASCADE
    ON UPDATE CASCADE);
  
  CREATE TABLE `hotel_db`.`customer` (
  `IRS_Number` VARCHAR(45) NOT NULL,
  `Street` VARCHAR(45) NULL,
  `Number` VARCHAR(45) NULL,
  `Postal_Code` INT NULL,
  `City` VARCHAR(45) NULL,
  `First_name` VARCHAR(45) NULL,
  `Last_name` VARCHAR(45) NULL,
  `Social_Security_Number` VARCHAR(45) NULL,
  `First_Registration` DATE NULL,
  PRIMARY KEY (`IRS_Number`));

CREATE TABLE `hotel_db`.`hotel_room` (
  `Room_id` INT NOT NULL,
  `Room_Number` INT NOT NULL,
  `Capacity` INT NULL,
  `View` VARCHAR(45) NULL,
  `Expandable` VARCHAR(45) NULL,
  `Repairs_need` VARCHAR(45) NULL,
  `Price` INT NULL,
  `Hotel_ID` INT NOT NULL,
  CONSTRAINT rooms UNIQUE (`Room_Number`,`Hotel_ID`),
  CONSTRAINT room_id UNIQUE (`Room_id`),
   CONSTRAINT `FK_HotelID`
	FOREIGN KEY (`Hotel_ID`)
    REFERENCES `hotel_db`.`hotel`(`hotel_ID`)
	ON DELETE CASCADE
    ON UPDATE CASCADE,
	PRIMARY KEY (`Room_id`,`Hotel_ID`));
    
 CREATE TABLE `hotel_db`.`amenities` (
  `Room_ID` INT NOT NULL,
  `Hotel_ID` INT NOT NULL,
  `Type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Room_ID`, `Hotel_ID`, `Type`),
 # INDEX `Hotel_ID_idx` (`Hotel_ID` ASC),
  CONSTRAINT `Room_ID`
    FOREIGN KEY (`Room_ID`)
    REFERENCES `hotel_db`.`hotel_room` (`Room_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Hotel_ID`
    FOREIGN KEY (`Hotel_ID`)
    REFERENCES `hotel_db`.`hotel` (`hotel_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
    
CREATE TABLE `hotel_db`.`payment_transaction` (
  `IRS_Number_Employee` VARCHAR(45) NOT NULL,
  `IRS_Number_Customer` VARCHAR(45) NOT NULL,
  `Room_ID` INT NOT NULL ,
  `Hotel_ID` INT NOT NULL ,
  `Payment_Amount` INT NULL,
  `Payment_Method` VARCHAR(45) NULL,
  PRIMARY KEY (`IRS_Number_Employee`,`IRS_Number_Customer`, `Room_ID`, `Hotel_ID`),
  INDEX `IRS_Number_Customer_idx` (`IRS_Number_Customer` ASC),
  INDEX `Room_ID_idx` (`Room_ID` ASC),
  INDEX `Hotel_ID_idx` (`Hotel_ID` ASC),
  CONSTRAINT `IRS_Number_Employee2`
  FOREIGN KEY (`IRS_Number_Employee`)
  REFERENCES `hotel_db`.`employee` (`IRS_Number`)
  ON DELETE NO ACTION
  ON UPDATE CASCADE,
  CONSTRAINT `IRS_Number_Customer2`
  FOREIGN KEY (`IRS_Number_Customer`)
  REFERENCES `hotel_db`.`customer` (`IRS_Number`)
  ON DELETE NO ACTION
  ON UPDATE CASCADE,
  CONSTRAINT `Room_ID3`
  FOREIGN KEY (`Room_ID`)
  REFERENCES `hotel_db`.`hotel_room` (`Room_id`)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
  CONSTRAINT `Hotel_ID3`
  FOREIGN KEY (`Hotel_ID`)
  REFERENCES `hotel_db`.`hotel` (`hotel_ID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE);


CREATE TABLE `hotel_db`.`works` (
  `IRS_Number_Employee` VARCHAR(45) NOT NULL,
  `Hotel_ID` INT NOT NULL,
  `Start_Date` DATE NOT NULL,
  `Position` VARCHAR(45) NOT NULL,
  `Finish_Date` DATE NULL,
  PRIMARY KEY (`IRS_Number_Employee`, `Hotel_ID`,`Start_Date`, `Position`),
  CONSTRAINT `IRS_Number_Employee`
  FOREIGN KEY (`IRS_Number_Employee`)
  REFERENCES `hotel_db`.`employee` (`IRS_Number`)
  ON DELETE NO ACTION
  ON UPDATE CASCADE,
  CONSTRAINT `Hotel_ID2`
  FOREIGN KEY (`Hotel_ID`)
  REFERENCES `hotel_db`.`hotel` (`hotel_ID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE);


CREATE TABLE `hotel_db`.`reserves` (
  `IRS_Number_Customer` VARCHAR(45) NOT NULL,
  `Room_ID` INT NOT NULL,
  `Hotel_ID` INT NOT NULL,
  `Hotel_name` VARCHAR(45) NULL,
  `Hotelgroup_name` VARCHAR(45) NULL,
  `Start_Date` DATE NOT NULL,
  `Paid` VARCHAR(45) NOT NULL,
  `Finish_Date` DATE NOT NULL,
  PRIMARY KEY (`IRS_Number_Customer`, `Room_ID`, `Hotel_ID`, `Start_Date`,`Finish_Date`),
  INDEX `Room_ID_idx` (`Room_ID` ASC),
  INDEX `Hotel_ID_idx` (`Hotel_ID` ASC),
  CONSTRAINT `IRS_Number_Customer1`
  FOREIGN KEY (`IRS_Number_Customer`)
  REFERENCES `hotel_db`.`customer` (`IRS_Number`)
  ON DELETE NO ACTION
  ON UPDATE CASCADE);
  

CREATE TABLE `hotel_db`.`rents` (
  `IRS_Number_Employee` VARCHAR(45) NOT NULL,
  `IRS_Number_Customer` VARCHAR(45) NOT NULL,
  `Room_id` INT NOT NULL,
  `Hotel_id` INT NOT NULL,
  `Hotel_name` VARCHAR(45) NULL,
  `Hotelgroup_name` VARCHAR(45) NULL,
  `Start_Date` DATE NOT NULL,
  `Finish_Date` DATE NOT NULL,
  PRIMARY KEY (IRS_Number_Employee, IRS_Number_Customer, Room_id, Hotel_id, Start_Date, Finish_Date),
  INDEX `IRS_Number_Customer_idx` (`IRS_Number_Customer` ASC),
  INDEX `Room_id_idx` (`Room_id` ASC),
  CONSTRAINT `IRS_Number_Employee1`
  FOREIGN KEY (`IRS_Number_Employee`)
  REFERENCES `hotel_db`.`employee` (`IRS_Number`)
  ON DELETE NO ACTION
  ON UPDATE CASCADE,
  CONSTRAINT `IRS_Number_Customer`
  FOREIGN KEY (`IRS_Number_Customer`)
  REFERENCES `hotel_db`.`customer` (`IRS_Number`)
  ON DELETE NO ACTION
  ON UPDATE CASCADE);
  

USE hotel_db;
DELIMITER $$

CREATE TRIGGER delete_on_hotel
AFTER DELETE ON hotel 
FOR EACH ROW 
BEGIN
UPDATE works SET Finish_Date = CURDATE() WHERE Hotel_ID = old.hotel_ID; 
END;
$$

DELIMITER ;

DELIMITER $$
USE `hotel_db`$$
CREATE DEFINER = CURRENT_USER TRIGGER hotel_db.`payment_transaction_AFTER_INSERT` AFTER INSERT ON payment_transaction FOR EACH ROW
BEGIN
UPDATE  reserves SET Paid="yes" WHERE Room_ID=new.Room_ID ;
END$$

DELIMITER ;

USE hotel_db;
DELIMITER $$

CREATE TRIGGER delete_on_hotel_room
AFTER DELETE ON hotel_room
FOR EACH ROW 
BEGIN
UPDATE hotel SET Number_of_rooms = Number_of_rooms-1 WHERE hotel_ID = old.Hotel_ID; 
END;
$$

DELIMITER ; 

USE hotel_db;
DELIMITER $$

CREATE TRIGGER insert_on_hotel_room
AFTER INSERT ON hotel_room
FOR EACH ROW 
BEGIN
UPDATE hotel SET Number_of_rooms = Number_of_rooms+1 WHERE hotel_ID = new.Hotel_ID; 
END;
$$

DELIMITER ; 

USE hotel_db;
DELIMITER $$

CREATE TRIGGER delete_on_hotel_group
AFTER DELETE ON hotel
FOR EACH ROW 
BEGIN
UPDATE hotel_group SET Number_of_hotels = Number_of_hotels-1 WHERE Hotel_group_ID = old.Hotelgroup_ID; 
END;
$$

DELIMITER ; 

USE hotel_db;
DELIMITER $$

CREATE TRIGGER insert_hotel_group
AFTER INSERT ON hotel
FOR EACH ROW 
BEGIN
UPDATE hotel_group SET Number_of_hotels = Number_of_hotels+1 WHERE Hotel_group_ID = new.Hotelgroup_ID; 
END;
$$

DELIMITER ; 

USE hotel_db;
DELIMITER $$

CREATE TRIGGER update_hotel
AFTER UPDATE ON hotel
FOR EACH ROW 
BEGIN
UPDATE rents SET Hotel_name = new.hotel_name WHERE Hotel_id = new.hotel_ID; 
UPDATE reserves SET Hotel_name = new.hotel_name WHERE Hotel_ID = new.hotel_ID; 
END;
$$

DELIMITER ; 


SET FOREIGN_KEY_CHECKS=0;
SET SQL_SAFE_UPDATES = 0;


INSERT INTO `hotel_db`.`hotel_group` (`Hotel_group_ID`, `hotelgroup_name`, `Street`, `Number`, `Postal_Code`, `City_group`, `Number_of_hotels`) VALUES ('1', 'Grecotel Resorts', 'Agisilaou', '36', '16562', 'Αthens', '0');
INSERT INTO `hotel_db`.`hotel_group` (`Hotel_group_ID`, `hotelgroup_name`, `Street`, `Number`, `Postal_Code`, `City_group`, `Number_of_hotels`) VALUES ('2', 'Olympian Resorts', 'krimeas', '88', '15055', 'Αthens', '0');
INSERT INTO `hotel_db`.`hotel_group` (`Hotel_group_ID`, `hotelgroup_name`,`Street`, `Number`, `Postal_Code`, `City_group`, `Number_of_hotels`) VALUES ('5', 'Oasis Hotels', 'Victoria St', '19', '30487', 'London', '0');
INSERT INTO `hotel_db`.`hotel_group` (`Hotel_group_ID`, `hotelgroup_name`, `Street`, `Number`, `Postal_Code`, `City_group`, `Number_of_hotels`) VALUES ('3', 'Delice Apartments', 'Ionias', '18', '10431', 'Chalikdiki', '0');
INSERT INTO `hotel_db`.`hotel_group` (`Hotel_group_ID`, `hotelgroup_name`, `Street`,`Number`, `Postal_Code`, `City_group`, `Number_of_hotels`) VALUES ('4', 'Philian Resorts', 'Kuprou', '34','84702', 'Santorini', '0');

INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ('1','1' ,'1', 'sea', '1 extra bed', 'no', '50', '1');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '2','2' ,'2', 'mountain', '2 extra beds', 'no', '60', '1');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '3', '3' ,'3', 'sea','1 extra bed', 'no', '70', '1');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '4','4' , '4', 'mountain', 'no', 'yes', '80', '1');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '5','5' , '5', 'sea', 'no', 'yes', '100', '1');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '6', '1','1', 'sea', '1 extra bed', 'no', '55', '2');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '7','2', '2', 'sea','communication with another room', 'no', '66', '2');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '8', '3','3', 'pool',  '1 extra bed', 'no', '77', '2');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ('9','4', '4', 'pool', 'no', 'no', '88', '2');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '10', '5','5', 'garden', 'no', 'no', '120', '2');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ('11', '1','1', 'park', 'communication with another room', 'no', '40', '3');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '12', '2','2', 'park', '1 extra bed', 'no', '60', '3');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '13', '3','3', 'mountain', 'no', 'no', '78', '3');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '14', '4','4', 'sea', 'no', 'yes', '90', '3');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ('15', '5','5', 'sea', 'no', 'yes', '130', '3');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '16', '1','1', 'mountain',  '1 extra bed', 'no', '37', '4');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ('17', '2','2', 'pool', 'no', 'no', '68', '4');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ('18', '3','3', 'pool', 'no', 'no', '90', '4');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '19', '4','4', 'garden', 'no', 'no', '120', '4');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '20', '5','5', 'garden', 'no', 'yes', '140', '4');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ('21', '1','1', 'garden', 'communication with another room', 'no', '60', '5');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '22', '2','2', 'pool',  '1 extra bed', 'no', '70', '5');
INSERT INTO `hotel_db`.`hotel_room` (`Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '23', '3','3', 'sea', 'communication with another room', 'no', '90', '5');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ('24', '4','4', 'sea', '1 extra bed', 'yes', '150', '5');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ('25', '5','5', 'park', 'no', 'yes', '170', '5');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '26', '1','1', 'sea', '2 extra beds', 'yes', '80', '6');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '27', '2','2', 'park', 'communication with another room', 'no', '130', '6');
INSERT INTO `hotel_db`.`hotel_room` (`Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '28', '3','3', 'park', '1 extra bed', 'no', '180', '6');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '29', '4','4', 'garden', 'communication with another room', 'no', '250', '6');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '30', '5','5', 'garden', '2 extra beds', 'no', '300', '6');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '31', '1','1', 'mountain', '1 extra bed', 'no', '50', '7');
INSERT INTO `hotel_db`.`hotel_room` (`Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '32', '2','2', 'garden', '1 extra bed', 'no', '100', '7');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '33', '3','3', 'sea', 'no', 'no', '200', '7');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '34', '4','4', 'sea', 'no', 'no', '300', '7');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '35', '5','5', 'sea', 'no', 'no', '400', '7');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '36', '1','1', 'garden', '2 extra beds', 'no', '100', '8');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '37', '2','2', 'garden', '1 extra bed', 'no', '140', '8');
INSERT INTO `hotel_db`.`hotel_room` (`Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '38', '3','3', 'sea', 'communication with another room', 'yes', '176', '8');
INSERT INTO `hotel_db`.`hotel_room` (`Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '39', '4','4', 'mountain', 'no', 'yes', '212', '8');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '40', '5','5', 'mountain', 'no', 'no', '265', '8');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '41', '1','1', 'mountain', '2 extra beds', 'no', '80', '9');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ('42', '2','2', 'garden', '1 extra bed', 'no', '180', '9');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '43', '3','3', 'sea', 'communication with another room', 'no', '200', '9');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '44', '4','4', 'sea','1 extra bed', 'no', '290', '9');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '45', '5','5', 'garden', 'no', 'no', '320', '9');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '46', '1','1', 'park',  '1 extra bed', 'yes', '60', '10');
INSERT INTO `hotel_db`.`hotel_room` (`Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '47', '2','2', 'park', 'communication with another room', 'yes', '80', '10');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '48', '3','3', 'sea',  '1 extra bed', 'no', '100', '10');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ('49', '4','4', 'sea', '2 extra beds', 'no', '250', '10');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '50', '5','5', 'sea', 'no', 'no', '300', '10');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '51', '1','1', 'street', 'no', 'no', '60', '11');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '52', '2','2', 'park', 'no', 'no', '90', '11');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '53', '3','3', 'street', 'communication with another room', 'no', '150', '11');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ('54', '4','4', 'park', '2 extra beds', 'no', '200', '11');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ('55', '5','5', 'street','1 extra bed', 'yes', '300', '11');
INSERT INTO `hotel_db`.`hotel_room` (`Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '56', '1','1', 'park', '1 extra bed', 'yes', '40', '12');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '57', '2','2', 'street', 'communication with another room', 'yes', '60', '12');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '58', '3','3', 'park','2 extra beds', 'no', '100', '12');
INSERT INTO `hotel_db`.`hotel_room` (`Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '59', '4','4', 'street','communication with another room', 'yes', '150', '12');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '60', '5','5', 'park',  'communication with another room', 'yes', '200', '12');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ('61', '1','1', 'street',  '1 extra bed', 'yes', '60', '13');
INSERT INTO `hotel_db`.`hotel_room` (`Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '62', '2','2', 'park', 'no', 'yes', '90', '13');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '63', '3','3', 'street', 'no', 'no', '120', '13');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '64', '4','4', 'park', 'no', 'no', '180', '13');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '65', '5','5', 'street', 'no', 'no', '220', '13');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '66', '1','1', 'park', 'no', 'no', '120', '14');
INSERT INTO `hotel_db`.`hotel_room` (`Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ('67', '2','2', 'street',  '1 extra bed', 'yes', '220', '14');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '68','3', '3', 'park', 'no', 'yes', '300', '14');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ('69', '4','4', 'street', 'communication with another room', 'yes', '360', '14');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '70', '5','5', 'park', 'communication with another room', 'yes', '450', '14');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '71', '1','1', 'street', 'no', 'no', '180', '15');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ('72', '2','2', 'park', 'no', 'yes', '250', '15');
INSERT INTO `hotel_db`.`hotel_room` (`Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ('73', '3','3', 'street', 'no', 'no', '360', '15');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '74', '4','4', 'park', 'no', 'yes', '500', '15');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ('75', '5','5', 'street','communication with another room', 'yes', '520', '15');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ('76', '1','1', 'sea', '1 extra bed', 'no', '80', '16');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '77', '2','2', 'mountain','communication with another room', 'no', '90', '16');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '78', '3','3', 'garden', 'no', 'no', '120', '16');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ('79', '4','4', 'pool', 'no', 'no', '130', '16');
INSERT INTO `hotel_db`.`hotel_room` (`Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '80', '5','5', 'sea', 'no', 'no', '150', '16');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ('81', '1','1', 'pool',  '1 extra bed', 'no', '30', '17');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '82', '2','2', 'garden', 'no', 'yes', '70', '17');
INSERT INTO `hotel_db`.`hotel_room` (`Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '83', '3','3', 'mountain','1 extra bed', 'no', '90', '17');
INSERT INTO `hotel_db`.`hotel_room` (`Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '84', '4','4', 'square', '1 extra bed', 'no', '120', '17');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '85', '5','5', 'sea', 'no', 'no', '130', '17');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '86', '1','1', 'garden',  'communication with another room', 'no', '50', '18');
INSERT INTO `hotel_db`.`hotel_room` (`Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ('87', '2','2', 'pool','1 extra bed', 'yes', '75', '18');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '88', '3','3', 'mountain', 'no', 'yes', '90', '18');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '89', '4','4', 'garden', 'no', 'no', '100', '18');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '90', '5','5', 'pool',  'communication with another room', 'no', '120', '18');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '91', '1','1', 'sea', 'no', 'no', '60', '19');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '92', '2','2', 'square','1 extra bed', 'no', '90', '19');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ('93', '3','3', 'mountain','2 extra beds', 'yes', '120', '19');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '94', '4','4', 'sea', 'no', 'no', '150', '19');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '95', '5','5', 'pool', '1 extra bed', 'no', '170', '19');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '96', '1','1', 'sea',  'communication with another room', 'no', '40', '20');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '97', '2','2', 'mountain', 'no', 'no', '60', '20');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ('98', '3','3', 'sea',  '1 extra bed', 'no', '80', '20');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '99', '4','4', 'sea', 'no', 'no', '90', '20');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '100', '5','5', 'pool', 'no', 'yes', '130', '20');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '101', '1','1', 'pool', '2 extra beds', 'no', '30', '21');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '102', '2','2', 'sea', 'no', 'no', '45', '21');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '103', '3','3', 'square', 'no', 'no', '70', '21');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '104', '4','4', 'mountain', '2 extra beds', 'no', '120', '21');
INSERT INTO `hotel_db`.`hotel_room` (`Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '105', '5','5', 'sea', 'no', 'no', '130', '21');
INSERT INTO `hotel_db`.`hotel_room` (`Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '106', '1','1', 'sea',  'communication with another room', 'no', '25', '22');
INSERT INTO `hotel_db`.`hotel_room` (`Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '107', '2','2', 'pool','1 extra bed', 'yes', '40', '22');
INSERT INTO `hotel_db`.`hotel_room` (`Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '108', '3','3', 'garden', 'no', 'no', '60', '22');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '109', '4','4', 'street', 'no', 'no', '80', '22');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '110', '5','5', 'street', 'no', 'no', '90', '22');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ('111', '1','1', 'garden', '2 extra beds', 'yes', '35', '23');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ('112', '2','2', 'mountain', 'communication with another room', 'yes', '70', '23');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ('113', '3','3', 'pool', 'no', 'no', '100', '23');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '114', '4','4', 'sea', '2 extra beds', 'no', '120', '23');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '115', '5','5', 'sea', 'no', 'yes', '150', '23');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '116', '1','1', 'street', '2 extra beds', 'no', '30', '24');
INSERT INTO `hotel_db`.`hotel_room` (`Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '117', '2','2', 'square', 'no', 'no', '45', '24');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '118', '3','3', 'sea', '2 extra beds', 'no', '60', '24');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '119', '4','4', 'mountain', 'no', 'yes', '75', '24');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '120', '5','5', 'pool', 'no', 'no', '90', '24');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '121', '1','1', 'sea', '2 extra beds', 'no', '25', '25');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '122', '2','2', 'mountain', '2 extra beds', 'no', '40', '25');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '123', '3','3', 'mountain', '1 extra bed', 'yes', '50', '25');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '124', '4','4', 'pool', 'no', 'no', '75', '25');
INSERT INTO `hotel_db`.`hotel_room` ( `Room_id`,`Room_Number`, `Capacity`, `View`, `Expandable`, `Repairs_need`, `Price`, `Hotel_ID`) VALUES ( '125', '5','5', 'garden', 'no', 'no', '90', '25');

INSERT INTO `hotel_db`.`hotel` (`hotel_ID`, `Street`, `Number`, `Postal_Code`, `City`, `Stars`, `Number_of_rooms`, `Hotelgroup_ID`) VALUES ('1', 'Alexandrou', '25', '14040', 'Thessaloniki', '4', '5', '1');
INSERT INTO `hotel_db`.`hotel` (`hotel_ID`, `Street`, `Number`, `Postal_Code`, `City`, `Stars`, `Number_of_rooms`, `Hotelgroup_ID`) VALUES ('2', 'El.Venizelou', '30', '14042', 'Thessaloniki', '3', '5','1');
INSERT INTO `hotel_db`.`hotel` (`hotel_ID`, `Street`, `Number`, `Postal_Code`, `City`, `Stars`, `Number_of_rooms`, `Hotelgroup_ID`) VALUES ('3', 'Mitropoleos', '35', '16040', 'Athens', '4', '5', '1');
INSERT INTO `hotel_db`.`hotel` (`hotel_ID`, `Street`, `Number`, `Postal_Code`, `City`, `Stars`, `Number_of_rooms`, `Hotelgroup_ID`) VALUES ('4', 'Panepistimiou', '50', '16042', 'Athens', '3', '5', '1');
INSERT INTO `hotel_db`.`hotel` (`hotel_ID`, `Street`, `Number`, `Postal_Code`, `City`, `Stars`, `Number_of_rooms`, `Hotelgroup_ID`) VALUES ('5', 'Korinthias', '36', '13030', 'Patras', '2', '5', '1');
INSERT INTO `hotel_db`.`hotel` (`hotel_ID`, `Street`, `Number`, `Postal_Code`, `City`, `Stars`, `Number_of_rooms`, `Hotelgroup_ID`) VALUES ('21', 'Theologou', '15', '30487', 'Rhodes', '3', '5', '5');
INSERT INTO `hotel_db`.`hotel` (`hotel_ID`, `Street`, `Number`, `Postal_Code`, `City`, `Stars`, `Number_of_rooms`, `Hotelgroup_ID`) VALUES ('22', 'Arionos', '2', '30487', 'Rhodes', '2', '5', '5');
INSERT INTO `hotel_db`.`hotel` (`hotel_ID`, `Street`, `Number`, `Postal_Code`, `City`, `Stars`, `Number_of_rooms`, `Hotelgroup_ID`) VALUES ('23', 'Themidos', '154', '30487', 'Rhodes', '3', '5', '5');
INSERT INTO `hotel_db`.`hotel` (`hotel_ID`, `Street`, `Number`, `Postal_Code`, `City`, `Stars`, `Number_of_rooms`, `Hotelgroup_ID`) VALUES ('24', 'Papandreou St', '8', '30487', 'Lefkada', '4', '5', '5');
INSERT INTO `hotel_db`.`hotel` (`hotel_ID`, `Street`, `Number`, `Postal_Code`, `City`, `Stars`, `Number_of_rooms`, `Hotelgroup_ID`) VALUES ('25', 'Venizelou', '42', '30487', 'Lefkada', '5', '5', '5');
INSERT INTO `hotel_db`.`hotel` (`hotel_ID`, `Street`, `Number`, `Postal_Code`, `City`, `Stars`, `Number_of_rooms`, `Hotelgroup_ID`) VALUES ('6', 'Kritis', '44', '12992', 'Rethimno', '4', '5', '2');
INSERT INTO `hotel_db`.`hotel` (`hotel_ID`, `Street`, `Number`, `Postal_Code`, `City`, `Stars`, `Number_of_rooms`, `Hotelgroup_ID`) VALUES ('7', 'Mpoumpoulinas', '38', '12543', 'Irakleio', '4', '5', '2');
INSERT INTO `hotel_db`.`hotel` (`hotel_ID`, `Street`, `Number`, `Postal_Code`, `City`, `Stars`, `Number_of_rooms`, `Hotelgroup_ID`) VALUES ('8', 'Kissamou', '73', '12224', 'Chania', '3', '5', '2');
INSERT INTO `hotel_db`.`hotel` (`hotel_ID`, `Street`, `Number`, `Postal_Code`, `City`, `Stars`, `Number_of_rooms`, `Hotelgroup_ID`) VALUES ('9', 'Selinou', '12', '12223', 'Chania', '2', '5', '2');
INSERT INTO `hotel_db`.`hotel` (`hotel_ID`, `Street`, `Number`, `Postal_Code`, `City`, `Stars`, `Number_of_rooms`, `Hotelgroup_ID`) VALUES ('10', 'Kolokotroni', '21', '10030', 'Volos', '2', '5', '2');
INSERT INTO `hotel_db`.`hotel` (`hotel_ID`,`Street`, `Number`, `Postal_Code`,`City`,`Stars`, `Number_of_rooms`,`Hotelgroup_ID`) VALUES ('11', 'Epanatasews', '42', '56211','Thessaloniki', '4', '5','3');
INSERT INTO `hotel_db`.`hotel` (`hotel_ID`,`Street`, `Number`, `Postal_Code`,`City`,`Stars`, `Number_of_rooms`,`Hotelgroup_ID`) VALUES ('12','Ioannou', '58','14221','Amorgos', '3', '5','3');
INSERT INTO `hotel_db`.`hotel` (`hotel_ID`,`Street`, `Number`, `Postal_Code`,`City`,`Stars`, `Number_of_rooms`,`Hotelgroup_ID`) VALUES ('13', 'Theologou', '41', '22656', 'Santorini', '2','5','3');
INSERT INTO `hotel_db`.`hotel` (`hotel_ID`,`Street`, `Number`, `Postal_Code`,`City`,`Stars`, `Number_of_rooms`,`Hotelgroup_ID`) VALUES ('14','25 MArtiou', '68', '56218', 'Thessaloniki','4', '5','3');
INSERT INTO `hotel_db`.`hotel` (`hotel_ID`,`Street`, `Number`, `Postal_Code`,`City`,`Stars`, `Number_of_rooms`,`Hotelgroup_ID`) VALUES ('15','Ethnikis Antistasews','87', '46983', 'Patra', '5', '5','3');
INSERT INTO `hotel_db`.`hotel` (`hotel_ID`,`Street`, `Number`, `Postal_Code`,`City`,`Stars`, `Number_of_rooms`,`Hotelgroup_ID`) VALUES ('16','Anastasews', '56','45682', 'Chalkidiki','4', '5','4');
INSERT INTO `hotel_db`.`hotel` (`hotel_ID`,`Street`, `Number`, `Postal_Code`,`City`,`Stars`, `Number_of_rooms`,`Hotelgroup_ID`) VALUES ('17','Eratous', '58', '12454','Nafplio','2', '5','4');
INSERT INTO `hotel_db`.`hotel` (`hotel_ID`,`Street`, `Number`, `Postal_Code`,`City`,`Stars`, `Number_of_rooms`,`Hotelgroup_ID`) VALUES ('18','Mukonou', '77', '46988','Patra', '3', '5','4');
INSERT INTO `hotel_db`.`hotel` (`hotel_ID`,`Street`, `Number`, `Postal_Code`,`City`,`Stars`, `Number_of_rooms`,`Hotelgroup_ID`) VALUES ('19', 'Aigaiou Pelagous','89', '14595', 'Milos','4','5','4');
INSERT INTO `hotel_db`.`hotel` (`hotel_ID`, `hotel_name`, `Street`, `Number`, `Postal_Code`, `City`, `Stars`, `Number_of_rooms`, `Hotelgroup_ID`) VALUES ('20', 'Fokia', 'Proppontidos', '2', '13342', 'Patra', '2', '5', '4');

UPDATE `hotel_db`.`hotel` SET `hotel_name` = 'Astoria' WHERE (`hotel_ID` = '1');
UPDATE `hotel_db`.`hotel` SET `hotel_name` = 'Aegean Houses' WHERE (`hotel_ID` = '12');
UPDATE `hotel_db`.`hotel` SET `hotel_name` = 'Dimitra Beach Hotel' WHERE (`hotel_ID` = '13');
UPDATE `hotel_db`.`hotel` SET `hotel_name` = 'Kosta Palace' WHERE (`hotel_ID` = '14');
UPDATE `hotel_db`.`hotel` SET `hotel_name` = 'Adonis City Hotel' WHERE (`hotel_ID` = '15');
UPDATE `hotel_db`.`hotel` SET `hotel_name` = 'Astir' WHERE (`hotel_ID` = '18');
UPDATE `hotel_db`.`hotel` SET `hotel_name` = 'Acropole' WHERE (`hotel_ID` = '5');
UPDATE `hotel_db`.`hotel` SET `hotel_name` = 'Diamond Suites' WHERE (`hotel_ID` = '2');
UPDATE `hotel_db`.`hotel` SET `hotel_name` = 'Hotel El Greco' WHERE (`hotel_ID` = '11');
UPDATE `hotel_db`.`hotel` SET `hotel_name` = 'Divani Caravel' WHERE (`hotel_ID` = '3');
UPDATE `hotel_db`.`hotel` SET `hotel_name` = 'President' WHERE (`hotel_ID` = '4');
UPDATE `hotel_db`.`hotel` SET `hotel_name` = 'Anelia Boutique' WHERE (`hotel_ID` = '21');
UPDATE `hotel_db`.`hotel` SET `hotel_name` = 'Vento Marino' WHERE (`hotel_ID` = '22');
UPDATE `hotel_db`.`hotel` SET `hotel_name` = 'Aphorite Studios' WHERE (`hotel_ID` = '23');
UPDATE `hotel_db`.`hotel` SET `hotel_name` = 'Anemones' WHERE (`hotel_ID` = '24');
UPDATE `hotel_db`.`hotel` SET `hotel_name` = 'Panorama Villas' WHERE (`hotel_ID` = '25');
UPDATE `hotel_db`.`hotel` SET `hotel_name` = 'Mimoza' WHERE (`hotel_ID` = '19');
UPDATE `hotel_db`.`hotel` SET `hotel_name` = 'Artemis Plaza' WHERE (`hotel_ID` = '16');
UPDATE `hotel_db`.`hotel` SET `hotel_name` = 'Filoxenia' WHERE (`hotel_ID` = '17');
UPDATE `hotel_db`.`hotel` SET `hotel_name` = 'Golden Bay' WHERE (`hotel_ID` = '6');
UPDATE `hotel_db`.`hotel` SET `hotel_name` = 'Koukounari' WHERE (`hotel_ID` = '7');
UPDATE `hotel_db`.`hotel` SET `hotel_name` = 'Sunset Studios' WHERE (`hotel_ID` = '8');
UPDATE `hotel_db`.`hotel` SET `hotel_name` = 'Liogerma' WHERE (`hotel_ID` = '9');
UPDATE `hotel_db`.`hotel` SET `hotel_name` = 'Volos Palace', `Stars` = '5' WHERE (`hotel_ID` = '10');

INSERT INTO `hotel_db`.`employee` (`IRS_Number`, `Last_Name`, `First_Name`, `Social_Security_Number`, `Street`, `Number`, `Postal_Code`, `City`) VALUES ('651561', 'Panagiwtou', 'Maria', '68845316', 'Othonos', '65', '84884', 'Athens');
INSERT INTO `hotel_db`.`employee` (`IRS_Number`, `Last_Name`, `First_Name`, `Social_Security_Number`, `Street`, `Number`, `Postal_Code`, `City`) VALUES ('545842', 'Angnwstou', 'Anna', '54894845', 'Mikonou', '89', '64684', 'Thessaloniki');
INSERT INTO `hotel_db`.`employee` (`IRS_Number`, `Last_Name`, `First_Name`, `Social_Security_Number`, `Street`, `Number`, `Postal_Code`, `City`) VALUES ('565435', 'Paleologou', 'Ioanna', '64651812', 'Athinas', '54', '65486', 'Patra');
INSERT INTO `hotel_db`.`employee` (`IRS_Number`, `Last_Name`, `First_Name`, `Social_Security_Number`, `Street`, `Number`, `Postal_Code`, `City`) VALUES ('544548', 'Pavlou', 'Katerina', '54646886', 'Peloponissou', '41', '65486', 'Athens');
INSERT INTO `hotel_db`.`employee` (`IRS_Number`, `Last_Name`, `First_Name`, `Social_Security_Number`, `Street`, `Number`, `Postal_Code`, `City`) VALUES ('545847', 'Filippou', 'Dimitris', '56487844', 'Kolokotroni', '89', '15156', 'Athens');
INSERT INTO `hotel_db`.`employee` (`IRS_Number`, `Last_Name`, `First_Name`, `Social_Security_Number`, `Street`, `Number`, `Postal_Code`, `City`) VALUES ('548889', 'Papadopoulos', 'Giannis', '65468488', 'Agiou Ioannou', '89', '89779', 'Patra');
INSERT INTO `hotel_db`.`employee` (`IRS_Number`, `Last_Name`, `First_Name`, `Social_Security_Number`, `Street`, `Number`, `Postal_Code`, `City`) VALUES ('798865', 'Zafiropoulos', 'Petros', '56464887', 'Theologou', '65', '87897', 'Naflpio');
INSERT INTO `hotel_db`.`employee` (`IRS_Number`, `Last_Name`, `First_Name`, `Social_Security_Number`, `Street`, `Number`, `Postal_Code`, `City`) VALUES ('213499', 'Zafrana', 'Sofia', '54654898', '25 Martiou', '21', '64898', 'Giannena');
INSERT INTO `hotel_db`.`employee` (`IRS_Number`, `Last_Name`, `First_Name`, `Social_Security_Number`, `Street`, `Number`, `Postal_Code`, `City`) VALUES ('548648', 'Linardou', 'Niki', '12432154', 'Antistasews', '45', '88748', 'Thessaloniki');
INSERT INTO `hotel_db`.`employee` (`IRS_Number`, `Last_Name`, `First_Name`, `Social_Security_Number`, `Street`, `Number`, `Postal_Code`, `City`) VALUES ('548984', 'Xatzipanagiwtou', 'Andreas', '21354684', 'Anastasews', '36', '48989', 'Volos');
INSERT INTO `hotel_db`.`employee` (`IRS_Number`, `Last_Name`, `First_Name`, `Social_Security_Number`, `Street`, `Number`, `Postal_Code`, `City`) VALUES ('564888', 'Dhmhtriou', 'Goergia', '13214897', 'Xanthipou', '87', '13131', 'Volos');
INSERT INTO `hotel_db`.`employee` (`IRS_Number`, `Last_Name`, `First_Name`, `Social_Security_Number`, `Street`, `Number`, `Postal_Code`, `City`) VALUES ('321564', 'Kosmidis', 'Stefanos', '21564987', 'Metonos', '45', '31564', 'Rhodes');
INSERT INTO `hotel_db`.`employee` (`IRS_Number`, `Last_Name`, `First_Name`, `Social_Security_Number`, `Street`, `Number`, `Postal_Code`, `City`) VALUES ('455489', 'Lamprou', 'Evi', '23131165', 'Eratous', '96', '65489', 'Athens');
INSERT INTO `hotel_db`.`employee` (`IRS_Number`, `Last_Name`, `First_Name`, `Social_Security_Number`, `Street`, `Number`, `Postal_Code`, `City`) VALUES ('344648', 'Spiropoulou', 'Eleni', '15465487', 'Koritsas', '26', '32131', 'Rethimno');
INSERT INTO `hotel_db`.`employee` (`IRS_Number`, `Last_Name`, `First_Name`, `Social_Security_Number`, `Street`, `Number`, `Postal_Code`, `City`) VALUES ('545464', 'Anagnwstakis', 'Giorgos', '21212445', 'Sarantaporou', '32', '54894', 'Irakleio');
INSERT INTO `hotel_db`.`employee` (`IRS_Number`, `Last_Name`, `First_Name`, `Social_Security_Number`, `Street`, `Number`, `Postal_Code`, `City`) VALUES ('648687', 'Dimopoulos', 'Vasilis', '44464867', 'Ymhttou', '12', '35448', 'Chania');
INSERT INTO `hotel_db`.`employee` (`IRS_Number`, `Last_Name`, `First_Name`, `Social_Security_Number`, `Street`, `Number`, `Postal_Code`, `City`) VALUES ('687897', 'Papadakis', 'Konstantinos', '23131544', 'Kyprou', '44', '64897', 'Chalkida');
INSERT INTO `hotel_db`.`employee` (`IRS_Number`, `Last_Name`, `First_Name`, `Social_Security_Number`, `Street`, `Number`, `Postal_Code`, `City`) VALUES ('684899', 'Deligiannakis', 'Pavlos', '54654648', 'Pindou', '55', '68798', 'Athens');
INSERT INTO `hotel_db`.`employee` (`IRS_Number`, `Last_Name`, `First_Name`, `Social_Security_Number`, `Street`, `Number`, `Postal_Code`, `City`) VALUES ('684848', 'Chronopoulos', 'Giannis', '21545486', 'Argyrokastrou', '56', '16544', 'Thessaloniki');
INSERT INTO `hotel_db`.`employee` (`IRS_Number`, `Last_Name`, `First_Name`, `Social_Security_Number`, `Street`, `Number`, `Postal_Code`, `City`) VALUES ('564899', 'Kolanis', 'Odisseas', '46484799', 'Pentelis', '95', '64687', 'Volos');
INSERT INTO `hotel_db`.`employee` (`IRS_Number`, `Last_Name`, `First_Name`, `Social_Security_Number`, `Street`, `Number`, `Postal_Code`, `City`) VALUES ('654889', 'Tsimidakis', 'Leonidas', '65468487', 'Epanastasews', '54', '87976', 'Athens');
INSERT INTO `hotel_db`.`employee` (`IRS_Number`, `Last_Name`, `First_Name`, `Social_Security_Number`, `Street`, `Number`, `Postal_Code`, `City`) VALUES ('684897', 'Hliadi', 'Maria', '15465488', 'Ethnikis Amynhs', '55', '65498', 'Patra');
INSERT INTO `hotel_db`.`employee` (`IRS_Number`, `Last_Name`, `First_Name`, `Social_Security_Number`, `Street`, `Number`, `Postal_Code`, `City`) VALUES ('878979', 'Meleti', 'Marilia', '54464886', 'Anagnwstou', '69', '65464', 'Patra');
INSERT INTO `hotel_db`.`employee` (`IRS_Number`, `Last_Name`, `First_Name`, `Social_Security_Number`, `Street`, `Number`, `Postal_Code`, `City`) VALUES ('646848', 'Vasiliadi', 'Marianna', '56464688', 'Anthewn', '88', '87987', 'Volos');
INSERT INTO `hotel_db`.`employee` (`IRS_Number`, `Last_Name`, `First_Name`, `Social_Security_Number`, `Street`, `Number`, `Postal_Code`, `City`) VALUES ('649879', 'Giannopoulos', 'Alexandros', '65464886', 'Delfwn', '89', '65456', 'Chania');



INSERT INTO `hotel_db`.`works` (`IRS_Number_Employee`, `Hotel_ID`, `Start_Date`, `Position`,`Finish_Date`) VALUES ('213499', '1', '2018-05-27', 'Manager','2018-09-30');
INSERT INTO `hotel_db`.`works` (`IRS_Number_Employee`, `Hotel_ID`, `Start_Date`, `Position`,`Finish_Date`) VALUES ('321564', '2', '2018-05-27', 'Manager','2018-09-30');
INSERT INTO `hotel_db`.`works` (`IRS_Number_Employee`, `Hotel_ID`, `Start_Date`, `Position`,`Finish_Date`) VALUES ('344648', '3', '2018-05-27', 'Manager','2018-09-30');
INSERT INTO `hotel_db`.`works` (`IRS_Number_Employee`, `Hotel_ID`, `Start_Date`, `Position`,`Finish_Date`) VALUES ('455489', '4', '2018-05-27', 'Manager','2018-09-30');
INSERT INTO `hotel_db`.`works` (`IRS_Number_Employee`, `Hotel_ID`, `Start_Date`, `Position`,`Finish_Date`) VALUES ('544548', '5', '2018-05-27', 'Manager','2018-09-30');
INSERT INTO `hotel_db`.`works` (`IRS_Number_Employee`, `Hotel_ID`, `Start_Date`, `Position`,`Finish_Date`) VALUES ('545464', '6', '2018-05-27', 'Manager','2018-09-30');
INSERT INTO `hotel_db`.`works` (`IRS_Number_Employee`, `Hotel_ID`, `Start_Date`, `Position`,`Finish_Date`) VALUES ('545842', '7', '2018-05-27', 'Manager','2018-09-30');
INSERT INTO `hotel_db`.`works` (`IRS_Number_Employee`, `Hotel_ID`, `Start_Date`, `Position`,`Finish_Date`) VALUES ('545847', '8', '2018-05-27', 'Manager','2018-09-30');
INSERT INTO `hotel_db`.`works` (`IRS_Number_Employee`, `Hotel_ID`, `Start_Date`, `Position`,`Finish_Date`) VALUES ('548648', '9', '2018-05-27', 'Manager','2018-09-30');
INSERT INTO `hotel_db`.`works` (`IRS_Number_Employee`, `Hotel_ID`, `Start_Date`, `Position`,`Finish_Date`) VALUES ('548889', '10', '2018-05-27', 'Manager','2018-09-30');
INSERT INTO `hotel_db`.`works` (`IRS_Number_Employee`, `Hotel_ID`, `Start_Date`, `Position`,`Finish_Date`) VALUES ('548984', '11', '2018-05-27', 'Manager','2018-09-30');
INSERT INTO `hotel_db`.`works` (`IRS_Number_Employee`, `Hotel_ID`, `Start_Date`, `Position`,`Finish_Date`) VALUES ('564888', '12', '2018-05-27', 'Manager','2018-09-30');
INSERT INTO `hotel_db`.`works` (`IRS_Number_Employee`, `Hotel_ID`, `Start_Date`, `Position`,`Finish_Date`) VALUES ('564899', '13', '2018-05-27', 'Manager','2018-09-30');
INSERT INTO `hotel_db`.`works` (`IRS_Number_Employee`, `Hotel_ID`, `Start_Date`, `Position`,`Finish_Date`) VALUES ('565435', '14', '2018-05-27', 'Manager','2018-09-30');
INSERT INTO `hotel_db`.`works` (`IRS_Number_Employee`, `Hotel_ID`, `Start_Date`, `Position`,`Finish_Date`) VALUES ('646848', '15', '2018-05-27', 'Manager','2018-09-30');
INSERT INTO `hotel_db`.`works` (`IRS_Number_Employee`, `Hotel_ID`, `Start_Date`, `Position`,`Finish_Date`) VALUES ('648687', '16', '2018-05-27', 'Manager','2018-09-30');
INSERT INTO `hotel_db`.`works` (`IRS_Number_Employee`, `Hotel_ID`, `Start_Date`, `Position`,`Finish_Date`) VALUES ('649879', '17', '2018-05-27', 'Manager','2018-09-30');
INSERT INTO `hotel_db`.`works` (`IRS_Number_Employee`, `Hotel_ID`, `Start_Date`, `Position`,`Finish_Date`) VALUES ('651561', '18', '2018-05-27', 'Manager','2018-09-30');
INSERT INTO `hotel_db`.`works` (`IRS_Number_Employee`, `Hotel_ID`, `Start_Date`, `Position`,`Finish_Date`) VALUES ('654889', '19', '2018-05-27', 'Manager','2018-09-30');
INSERT INTO `hotel_db`.`works` (`IRS_Number_Employee`, `Hotel_ID`, `Start_Date`, `Position`,`Finish_Date`) VALUES ('684848', '20', '2018-05-27', 'Manager','2018-09-30');
INSERT INTO `hotel_db`.`works` (`IRS_Number_Employee`, `Hotel_ID`, `Start_Date`, `Position`,`Finish_Date`) VALUES ('684897', '21', '2018-05-27', 'Manager','2018-09-30');
INSERT INTO `hotel_db`.`works` (`IRS_Number_Employee`, `Hotel_ID`, `Start_Date`, `Position`,`Finish_Date`) VALUES ('684899', '22', '2018-05-27', 'Manager','2018-09-30');
INSERT INTO `hotel_db`.`works` (`IRS_Number_Employee`, `Hotel_ID`, `Start_Date`, `Position`,`Finish_Date`) VALUES ('687897', '23', '2018-05-27', 'Manager','2018-09-30');
INSERT INTO `hotel_db`.`works` (`IRS_Number_Employee`, `Hotel_ID`, `Start_Date`, `Position`,`Finish_Date`) VALUES ('798865', '24', '2018-05-27', 'Manager','2018-09-30');
INSERT INTO `hotel_db`.`works` (`IRS_Number_Employee`, `Hotel_ID`, `Start_Date`, `Position`,`Finish_Date`) VALUES ('878979', '25', '2018-05-27', 'Manager','2018-09-30');


INSERT INTO `hotel_db`.`phone_hotel_group` (`Hotel_group_ID`, `Phone_number`) VALUES ('1', '2109643927');
INSERT INTO `hotel_db`.`phone_hotel_group` (`Hotel_group_ID`, `Phone_number`) VALUES ('2', '2109903999');
INSERT INTO `hotel_db`.`phone_hotel_group` (`Hotel_group_ID`, `Phone_number`) VALUES ('3', '2108425603');
INSERT INTO `hotel_db`.`phone_hotel_group` (`Hotel_group_ID`, `Phone_number`) VALUES ('4', '2296048506');
INSERT INTO `hotel_db`.`phone_hotel_group` (`Hotel_group_ID`, `Phone_number`) VALUES ('5', '2294675506');

INSERT INTO `hotel_db`.`phone_hotel` (`Hotel_ID`, `Phone_number`) VALUES ('11', '2658749652');
INSERT INTO `hotel_db`.`phone_hotel` (`Hotel_ID`, `Phone_number`) VALUES ('12', '2154789662');
INSERT INTO `hotel_db`.`phone_hotel` (`Hotel_ID`, `Phone_number`) VALUES ('13', '2685248521');
INSERT INTO `hotel_db`.`phone_hotel` (`Hotel_ID`, `Phone_number`) VALUES ('14', '2268821145');
INSERT INTO `hotel_db`.`phone_hotel` (`Hotel_ID`, `Phone_number`) VALUES ('15', '2115874285');
INSERT INTO `hotel_db`.`phone_hotel` (`Hotel_ID`, `Phone_number`) VALUES ('16', '1158874155');
INSERT INTO `hotel_db`.`phone_hotel` (`Hotel_ID`, `Phone_number`) VALUES ('17', '1554875145');
INSERT INTO `hotel_db`.`phone_hotel` (`Hotel_ID`, `Phone_number`) VALUES ('18', '1547761115');
INSERT INTO `hotel_db`.`phone_hotel` (`Hotel_ID`, `Phone_number`) VALUES ('19', '4478879745');
INSERT INTO `hotel_db`.`phone_hotel` (`Hotel_ID`, `Phone_number`) VALUES ('20', '5548764514');
INSERT INTO `hotel_db`.`phone_hotel` (`Hotel_ID`, `Phone_number`) VALUES ('21', '4567890987');
INSERT INTO `hotel_db`.`phone_hotel` (`Hotel_ID`, `Phone_number`) VALUES ('22', '5987652667');
INSERT INTO `hotel_db`.`phone_hotel` (`Hotel_ID`, `Phone_number`) VALUES ('23', '6767878787');
INSERT INTO `hotel_db`.`phone_hotel` (`Hotel_ID`, `Phone_number`) VALUES ('24', '6672576766');
INSERT INTO `hotel_db`.`phone_hotel` (`Hotel_ID`, `Phone_number`) VALUES ('25', '1425679904');
INSERT INTO `hotel_db`.`phone_hotel` (`Hotel_ID`, `Phone_number`) VALUES ('1', '5678893656');
INSERT INTO `hotel_db`.`phone_hotel` (`Hotel_ID`, `Phone_number`) VALUES ('2', '6872356893');
INSERT INTO `hotel_db`.`phone_hotel` (`Hotel_ID`, `Phone_number`) VALUES ('3', '4783723467');
INSERT INTO `hotel_db`.`phone_hotel` (`Hotel_ID`, `Phone_number`) VALUES ('4', '4647325675');
INSERT INTO `hotel_db`.`phone_hotel` (`Hotel_ID`, `Phone_number`) VALUES ('5', '7634722775');
INSERT INTO `hotel_db`.`phone_hotel` (`Hotel_ID`, `Phone_number`) VALUES ('6', '7894635766');
INSERT INTO `hotel_db`.`phone_hotel` (`Hotel_ID`, `Phone_number`) VALUES ('7', '7676576735');
INSERT INTO `hotel_db`.`phone_hotel` (`Hotel_ID`, `Phone_number`) VALUES ('8', '2657689546');
INSERT INTO `hotel_db`.`phone_hotel` (`Hotel_ID`, `Phone_number`) VALUES ('9', '5876434468');
INSERT INTO `hotel_db`.`phone_hotel` (`Hotel_ID`, `Phone_number`) VALUES ('10', '5457643788');



INSERT INTO `hotel_db`.`email_hotel` (`Hotel_ID`, `Email_Address`) VALUES ('1', 'hotels1@gmail.com');
INSERT INTO `hotel_db`.`email_hotel` (`Hotel_ID`, `Email_Address`) VALUES ('2', 'hotels2@gmail.com');
INSERT INTO `hotel_db`.`email_hotel` (`Hotel_ID`, `Email_Address`) VALUES ('3', 'hotels3@gmail.com');
INSERT INTO `hotel_db`.`email_hotel` (`Hotel_ID`, `Email_Address`) VALUES ('4', 'hotels4@gmail.com');
INSERT INTO `hotel_db`.`email_hotel` (`Hotel_ID`, `Email_Address`) VALUES ('5', 'hotels5@gmail.com');
INSERT INTO `hotel_db`.`email_hotel` (`Hotel_ID`, `Email_Address`) VALUES ('6', 'hotels6@gmail.com');
INSERT INTO `hotel_db`.`email_hotel` (`Hotel_ID`, `Email_Address`) VALUES ('7', 'hotels7@gmail.com');
INSERT INTO `hotel_db`.`email_hotel` (`Hotel_ID`, `Email_Address`) VALUES ('8', 'hotels8@gmail.com');
INSERT INTO `hotel_db`.`email_hotel` (`Hotel_ID`, `Email_Address`) VALUES ('9', 'hotels9@gmail.com');
INSERT INTO `hotel_db`.`email_hotel` (`Hotel_ID`, `Email_Address`) VALUES ('10', 'hotels10@gmail.com');
INSERT INTO `hotel_db`.`email_hotel` (`Hotel_ID`, `Email_Address`) VALUES ('11', 'hotels11@gmail.com');
INSERT INTO `hotel_db`.`email_hotel` (`Hotel_ID`, `Email_Address`) VALUES ('12', 'hotels12@gmail.com');
INSERT INTO `hotel_db`.`email_hotel` (`Hotel_ID`, `Email_Address`) VALUES ('13', 'hotels13@gmail.com');
INSERT INTO `hotel_db`.`email_hotel` (`Hotel_ID`, `Email_Address`) VALUES ('14', 'hotels14@gmail.com');
INSERT INTO `hotel_db`.`email_hotel` (`Hotel_ID`, `Email_Address`) VALUES ('15', 'hotels15@gmail.com');
INSERT INTO `hotel_db`.`email_hotel` (`Hotel_ID`, `Email_Address`) VALUES ('16', 'hotels16@gmail.com');
INSERT INTO `hotel_db`.`email_hotel` (`Hotel_ID`, `Email_Address`) VALUES ('17', 'hotels17@gmail.com');
INSERT INTO `hotel_db`.`email_hotel` (`Hotel_ID`, `Email_Address`) VALUES ('18', 'hotels18@gmail.com');
INSERT INTO `hotel_db`.`email_hotel` (`Hotel_ID`, `Email_Address`) VALUES ('19', 'hotels19@gmail.com');
INSERT INTO `hotel_db`.`email_hotel` (`Hotel_ID`, `Email_Address`) VALUES ('20', 'hotels20@gmail.com');
INSERT INTO `hotel_db`.`email_hotel` (`Hotel_ID`, `Email_Address`) VALUES ('21', 'hotels21@gmail.com');
INSERT INTO `hotel_db`.`email_hotel` (`Hotel_ID`, `Email_Address`) VALUES ('22', 'hotels22@gmail.com');
INSERT INTO `hotel_db`.`email_hotel` (`Hotel_ID`, `Email_Address`) VALUES ('23', 'hotels23@gmail.com');
INSERT INTO `hotel_db`.`email_hotel` (`Hotel_ID`, `Email_Address`) VALUES ('24', 'hotels24@gmail.com');
INSERT INTO `hotel_db`.`email_hotel` (`Hotel_ID`, `Email_Address`) VALUES ('25', 'hotels25@gmail.com');


INSERT INTO `hotel_db`.`email_hotel_group` (`Hotel_group_ID`, `Email_Address`) VALUES ('1', 'dolphin_hotel@gmail.com');
INSERT INTO `hotel_db`.`email_hotel_group` (`Hotel_group_ID`, `Email_Address`) VALUES ('2', 'ionia_hotels@gmail.com');
INSERT INTO `hotel_db`.`email_hotel_group` (`Hotel_group_ID`, `Email_Address`) VALUES ('3', 'grecotel@gmail.com');
INSERT INTO `hotel_db`.`email_hotel_group` (`Hotel_group_ID`, `Email_Address`) VALUES ('4', 'aldemar@gmail.com');
INSERT INTO `hotel_db`.`email_hotel_group` (`Hotel_group_ID`, `Email_Address`) VALUES ('5', 'mermaid@gmail.com');

INSERT INTO `hotel_db`.`amenities` (`Room_id`, `Hotel_ID`, `Type`) VALUES ('1', '1', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('2', '1', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('3', '1', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('4', '1', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('5', '1', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('6', '2', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('7', '2', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('8', '2', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('9', '2', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('10', '2', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('11', '3', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('12', '3', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('13', '3', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('14', '3', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('15', '3', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('16', '4', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('17', '4', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('18', '4', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('19', '4', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('20', '4', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('21', '5', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('22', '5', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('23', '5', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('24', '5', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('25', '5', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('27', '6', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('29', '6', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('31', '7', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('33', '7', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('34', '7', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('37', '8', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('38', '8', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('39', '8', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('40', '8', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('41', '9', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('42', '9', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('51', '11', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('53', '11', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('54', '11', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('55', '11', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('56', '12', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('57', '12', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('59', '12', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('61', '13', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('62', '13', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('63', '13', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('64', '13', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('65', '13', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('66', '14', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('67', '14', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('68', '14', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('69', '14', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('73', '15', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('74', '15', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('75', '15', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('76', '16', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('77', '16', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('78', '16', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('79', '16', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('80', '16', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('81', '17', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('82', '17', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('83', '17', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('84', '17', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('85', '17', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('86', '18', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('87', '18', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('88', '18', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('89', '18', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('90', '18', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('91', '19', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('92', '19', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('93', '19', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('94', '19', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('95', '19', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('96', '20', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('97', '20', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('98', '20', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('99', '20', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('100', '20', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('101', '21', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('102', '21', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('103', '21', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('104', '21', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('105', '21', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('106', '22', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('107', '22', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('108', '22', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('109', '22', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('110', '22', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('112', '23', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('114', '23', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('116', '24', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('117', '24', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('118', '24', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('120', '24', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('121', '25', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('122', '25', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('125', '25', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('1', '1', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('2', '1', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('3', '1', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('5', '1', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('7', '2', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('8', '2', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('9', '2', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('11', '3', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('12', '3', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('13', '3', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('14', '3', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('15', '3', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('17', '4', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('18', '4', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('19', '4', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('20', '4', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('21', '5', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('22', '5', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('23', '5', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('24', '5', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('26', '6', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('27', '6', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('28', '6', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('29', '6', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('30', '6', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('31', '7', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('32', '7', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('34', '7', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('37', '8', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('38', '8', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('39', '8', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('40', '8', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('41', '9', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('43', '9', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('44', '9', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('45', '9', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('46', '10', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('47', '10', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('48', '10', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('49', '10', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('50', '10', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('51', '11', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('52', '11', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('54', '11', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('55', '11', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('60', '12', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('61', '13', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('62', '13', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('63', '13', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('64', '13', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('65', '13', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('66', '14', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('67', '14', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('68', '14', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('69', '14', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('70', '14', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('71', '15', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('72', '15', 'Balcony');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('73', '15', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('74', '15', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('75', '15', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('76', '16', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('77', '16', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('78', '16', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('79', '16', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('80', '16', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('82', '17', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('84', '17', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('85', '17', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('86', '18', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('87', '18', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('88', '18', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('89', '18', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('91', '19', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('92', '19', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('93', '19', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('94', '19', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('99', '20', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('100', '20', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('101', '21', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('102', '21', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('103', '21', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('104', '21', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('109', '22', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('110', '22', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('111', '23', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('112', '23', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('113', '23', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('115', '23', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('116', '24', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('117', '24', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('121', '25', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('122', '25', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('124', '25', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('125', '25', 'Hairdryer');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('1', '1', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('2', '1', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('4', '1', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('6', '2', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('7', '2', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('8', '2', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('10', '2', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('11', '3', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('12', '3', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('13', '3', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('14', '3', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('16', '4', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('17', '4', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('18', '4', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('19', '4', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('21', '5', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('22', '5', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('23', '5', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('24', '5', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('26', '6', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('27', '6', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('28', '6', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('29', '6', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('30', '6', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('31', '7', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('32', '7', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('34', '7', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('35', '7', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('36', '8', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('38', '8', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('39', '8', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('40', '8', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('41', '9', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('42', '9', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('43', '9', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('44', '9', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('45', '9', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('46', '10', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('48', '10', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('50', '10', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('51', '11', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('53', '11', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('54', '11', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('56', '12', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('57', '12', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('58', '12', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('59', '12', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('61', '13', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('62', '13', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('63', '13', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('64', '13', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('65', '13', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('67', '14', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('68', '14', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('69', '14', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('70', '14', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('71', '15', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('72', '15', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('73', '15', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('74', '15', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('75', '15', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('76', '16', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('77', '16', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('78', '16', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('79', '16', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('80', '16', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('81', '17', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('82', '17', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('84', '17', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('86', '18', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('88', '18', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('89', '18', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('91', '19', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('93', '19', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('95', '19', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('96', '20', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('97', '20', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('99', '20', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('102', '21', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('103', '21', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('104', '21', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('105', '21', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('109', '22', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('110', '22', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('111', '23', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('113', '23', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('114', '23', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('119', '24', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('121', '25', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('122', '25', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('124', '25', 'AirConditioning');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('2', '1', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('4', '1', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('5', '1', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('6', '2', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('7', '2', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('9', '2', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('10', '2', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('11', '3', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('12', '3', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('13', '3', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('14', '3', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('15', '3', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('16', '4', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('17', '4', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('18', '4', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('19', '4', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('20', '4', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('21', '5', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('22', '5', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('23', '5', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('25', '5', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('26', '6', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('27', '6', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('28', '6', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('30', '6', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('31', '7', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('32', '7', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('33', '7', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('34', '7', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('35', '7', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('36', '8', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('37', '8', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('39', '8', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('40', '8', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('41', '9', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('43', '9', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('44', '9', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('46', '10', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('47', '10', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('48', '10', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('50', '10', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('51', '11', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('52', '11', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('53', '11', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('55', '11', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('56', '12', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('57', '12', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('58', '12', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('59', '12', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('61', '13', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('62', '13', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('63', '13', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('64', '13', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('65', '13', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('66', '14', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('67', '14', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('68', '14', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('69', '14', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('71', '15', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('72', '15', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('73', '15', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('76', '16', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('77', '16', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('78', '16', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('79', '16', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('81', '17', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('82', '17', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('83', '17', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('84', '17', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('85', '17', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('86', '18', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('87', '18', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('88', '18', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('91', '19', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('92', '19', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('93', '19', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('95', '19', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('96', '20', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('98', '20', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('99', '20', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('101', '21', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('102', '21', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('103', '21', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('105', '21', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('106', '22', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('107', '22', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('108', '22', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('110', '22', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('111', '23', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('112', '23', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('113', '23', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('114', '23', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('115', '23', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('116', '24', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('117', '24', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('118', '24', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('119', '24', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('122', '25', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('123', '25', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('125', '25', 'TV');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('4', '1', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('5', '1', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('7', '2', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('9', '2', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('10', '2', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('11', '3', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('14', '3', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('15', '3', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('17', '4', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('19', '4', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('20', '4', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('23', '5', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('24', '5', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('25', '5', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('27', '6', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('28', '6', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('29', '6', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('30', '6', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('31', '7', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('32', '7', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('33', '7', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('35', '7', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('36', '8', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('37', '8', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('38', '8', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('40', '8', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('41', '9', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('42', '9', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('43', '9', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('44', '9', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('45', '9', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('46', '10', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('47', '10', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('48', '10', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('49', '10', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('50', '10', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('51', '11', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('52', '11', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('53', '11', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('54', '11', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('55', '11', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('56', '12', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('57', '12', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('58', '12', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('59', '12', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('60', '12', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('61', '13', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('62', '13', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('63', '13', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('64', '13', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('65', '13', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('66', '14', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('67', '14', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('68', '14', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('69', '14', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('70', '14', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('71', '15', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('72', '15', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('73', '15', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('74', '15', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('75', '15', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('76', '16', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('77', '16', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('78', '16', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('79', '16', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('80', '16', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('81', '17', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('84', '17', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('86', '18', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('87', '18', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('91', '19', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('92', '19', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('94', '19', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('97', '20', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('98', '20', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('99', '20', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('100', '20', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('101', '21', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('104', '21', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('105', '21', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('106', '22', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('107', '22', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('109', '22', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('110', '22', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('112', '23', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('113', '23', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('114', '23', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('116', '24', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('117', '24', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('120', '24', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('121', '25', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('122', '25', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('123', '25', 'MiniFridge');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('1', '1', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('3', '1', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('5', '1', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('7', '2', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('8', '2', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('9', '2', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('10', '2', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('11', '3', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('12', '3', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('14', '3', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('15', '3', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('16', '4', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('17', '4', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('19', '4', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('22', '5', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('23', '5', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('24', '5', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('25', '5', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('26', '6', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('27', '6', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('28', '6', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('29', '6', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('30', '6', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('31', '7', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('32', '7', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('33', '7', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('34', '7', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('36', '8', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('37', '8', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('38', '8', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('40', '8', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('41', '9', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('43', '9', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('44', '9', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('45', '9', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('47', '10', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('48', '10', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('49', '10', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('50', '10', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('51', '11', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('52', '11', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('53', '11', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('54', '11', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('55', '11', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('56', '12', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('57', '12', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('59', '12', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('60', '12', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('61', '13', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('62', '13', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('63', '13', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('64', '13', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('65', '13', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('66', '14', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('68', '14', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('69', '14', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('71', '15', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('72', '15', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('73', '15', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('74', '15', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('76', '16', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('77', '16', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('80', '16', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('81', '17', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('82', '17', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('83', '17', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('84', '17', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('85', '17', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('86', '18', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('89', '18', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('90', '18', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('91', '19', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('93', '19', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('94', '19', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('95', '19', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('96', '20', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('98', '20', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('100', '20', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('101', '21', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('104', '21', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('105', '21', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('106', '22', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('107', '22', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('108', '22', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('110', '22', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('112', '23', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('113', '23', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('114', '23', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('115', '23', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('116', '24', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('117', '24', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('121', '25', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('122', '25', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('123', '25', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('124', '25', 'Towels');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('2', '1', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('3', '1', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('4', '1', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('5', '1', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('6', '2', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('7', '2', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('8', '2', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('9', '2', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('10', '2', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('12', '3', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('13', '3', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('14', '3', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('16', '4', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('17', '4', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('19', '4', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('22', '5', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('23', '5', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('26', '6', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('27', '6', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('28', '6', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('29', '6', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('30', '6', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('36', '8', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('37', '8', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('38', '8', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('40', '8', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('43', '9', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('44', '9', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('48', '10', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('49', '10', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('50', '10', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('53', '11', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('54', '11', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('56', '12', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('59', '12', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('61', '13', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('62', '13', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('63', '13', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('67', '14', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('70', '14', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('72', '15', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('74', '15', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('75', '15', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('76', '16', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('77', '16', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('78', '16', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('80', '16', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('81', '17', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('83', '17', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('84', '17', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('85', '17', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('86', '18', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('88', '18', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('89', '18', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('90', '18', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('92', '19', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('93', '19', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('94', '19', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('96', '20', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('97', '20', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('99', '20', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('100', '20', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('101', '21', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('102', '21', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('103', '21', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('104', '21', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('106', '22', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('107', '22', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('108', '22', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('109', '22', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('110', '22', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('112', '23', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('113', '23', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('114', '23', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('116', '24', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('117', '24', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('118', '24', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('119', '24', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('120', '24', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('121', '25', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('123', '25', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('124', '25', 'RoomService');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('1', '1', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('2', '1', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('3', '1', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('4', '1', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('5', '1', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('6', '2', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('7', '2', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('8', '2', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('9', '2', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('10', '2', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('11', '3', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('12', '3', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('13', '3', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('14', '3', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('15', '3', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('16', '4', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('17', '4', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('18', '4', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('19', '4', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('20', '4', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('21', '5', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('22', '5', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('23', '5', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('24', '5', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('25', '5', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('26', '6', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('27', '6', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('28', '6', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('29', '6', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('30', '6', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('32', '7', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('33', '7', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('34', '7', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('35', '7', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('36', '8', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('37', '8', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('39', '8', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('41', '9', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('42', '9', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('43', '9', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('44', '9', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('45', '9', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('46', '10', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('48', '10', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('50', '10', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('51', '11', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('52', '11', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('54', '11', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('56', '12', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('57', '12', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('58', '12', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('59', '12', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('60', '12', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('62', '13', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('63', '13', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('64', '13', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('65', '13', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('66', '14', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('68', '14', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('71', '15', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('73', '15', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('74', '15', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('76', '16', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('77', '16', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('78', '16', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('80', '16', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('81', '17', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('82', '17', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('84', '17', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('85', '17', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('86', '18', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('87', '18', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('90', '18', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('91', '19', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('93', '19', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('95', '19', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('96', '20', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('97', '20', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('98', '20', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('99', '20', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('100', '20', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('101', '21', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('104', '21', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('105', '21', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('106', '22', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('108', '22', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('109', '22', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('110', '22', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('111', '23', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('112', '23', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('113', '23', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('115', '23', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('117', '24', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('118', '24', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('120', '24', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('121', '25', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('122', '25', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('123', '25', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('124', '25', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('125', '25', 'Spa');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('2', '1', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('4', '1', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('6', '2', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('7', '2', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('8', '2', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('10', '2', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('11', '3', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('12', '3', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('13', '3', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('14', '3', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('16', '4', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('17', '4', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('19', '4', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('20', '4', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('21', '5', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('23', '5', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('24', '5', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('25', '5', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('27', '6', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('28', '6', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('29', '6', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('30', '6', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('32', '7', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('33', '7', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('35', '7', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('36', '8', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('37', '8', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('38', '8', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('40', '8', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('41', '9', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('42', '9', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('43', '9', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('45', '9', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('47', '10', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('48', '10', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('49', '10', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('50', '10', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('52', '11', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('53', '11', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('54', '11', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('55', '11', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('56', '12', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('58', '12', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('59', '12', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('60', '12', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('61', '13', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('63', '13', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('64', '13', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('65', '13', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('66', '14', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('67', '14', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('68', '14', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('69', '14', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('70', '14', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('71', '15', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('72', '15', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('73', '15', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('74', '15', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('76', '16', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('77', '16', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('78', '16', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('79', '16', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('81', '17', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('82', '17', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('83', '17', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('84', '17', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('86', '18', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('87', '18', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('90', '18', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('92', '19', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('94', '19', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('95', '19', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('97', '20', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('99', '20', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('100', '20', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('101', '21', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('102', '21', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('103', '21', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('105', '21', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('106', '22', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('107', '22', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('108', '22', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('111', '23', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('112', '23', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('113', '23', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('114', '23', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('118', '24', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('119', '24', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('121', '25', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('122', '25', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('123', '25', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('125', '25', 'PrivatePool');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('1', '1', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('2', '1', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('4', '1', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('6', '2', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('7', '2', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('8', '2', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('10', '2', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('11', '3', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('12', '3', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('13', '3', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('14', '3', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('16', '4', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('17', '4', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('18', '4', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('20', '4', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('21', '5', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('22', '5', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('23', '5', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('26', '6', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('27', '6', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('28', '6', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('29', '6', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('30', '6', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('31', '7', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('32', '7', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('34', '7', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('35', '7', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('37', '8', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('38', '8', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('40', '8', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('41', '9', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('42', '9', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('43', '9', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('44', '9', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('47', '10', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('48', '10', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('49', '10', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('50', '10', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('51', '11', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('52', '11', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('53', '11', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('54', '11', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('56', '12', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('57', '12', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('58', '12', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('60', '12', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('61', '13', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('62', '13', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('63', '13', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('64', '13', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('65', '13', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('67', '14', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('68', '14', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('69', '14', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('70', '14', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('71', '15', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('72', '15', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('74', '15', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('75', '15', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('76', '16', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('77', '16', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('78', '16', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('79', '16', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('80', '16', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('81', '17', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('82', '17', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('83', '17', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('84', '17', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('86', '18', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('87', '18', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('88', '18', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('91', '19', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('92', '19', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('93', '19', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('94', '19', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('95', '19', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('96', '20', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('97', '20', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('98', '20', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('100', '20', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('101', '21', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('102', '21', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('103', '21', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('104', '21', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('106', '22', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('107', '22', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('108', '22', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('109', '22', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('110', '22', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('111', '23', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('112', '23', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('114', '23', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('116', '24', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('117', '24', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('118', '24', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('119', '24', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('120', '24', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('121', '25', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('124', '25', 'Breakfast');
INSERT INTO `hotel_db`.`amenities` (`Room_ID`, `Hotel_ID`, `Type`) VALUES ('125', '25', 'Breakfast');


SET SQL_SAFE_UPDATES = 1;
SET FOREIGN_KEY_CHECKS=1;
