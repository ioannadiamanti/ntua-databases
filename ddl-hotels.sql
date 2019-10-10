DROP SCHEMA IF EXISTS `hotel_db` ;

CREATE SCHEMA `hotel_db` ;

CREATE TABLE `hotel_db`.`employee` (
  `IRS_Number` VARCHAR(45) NOT NULL,
  `Last_Name` VARCHAR(45) NULL,
  `First_Name` VARCHAR(45) NULL,
  `Social_Security_Number` VARCHAR(45) NULL,
  `Street` VARCHAR(45) NULL,
  `Number` VARCHAR(45) NULL,
  `Postal_Code` VARCHAR(45) NULL,
  `City` VARCHAR(45) NULL,
  PRIMARY KEY (`IRS_Number`));
  
  CREATE TABLE `hotel_db`.`hotel_group` (
  `Hotel_group_ID` INT NOT NULL,
  `hotelgroup_name` VARCHAR(45) NULL,
  `Street` VARCHAR(45) NULL,
  `Number` VARCHAR(45) NULL,
  `Postal_Code` VARCHAR(45) NULL,
  `City_group` VARCHAR(45) NULL,
  `Number_of_hotels` INT NULL,
  PRIMARY KEY (`Hotel_group_ID`));
  
  CREATE TABLE `hotel_db`.`hotel` (
  `hotel_ID` INT NOT NULL,
  `hotel_name` VARCHAR(45) NULL,
  `Street` VARCHAR(45) NULL,
  `Number` VARCHAR(45) NULL,
  `Postal_Code` VARCHAR(45) NULL,
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
  `Postal_Code` VARCHAR(45) NULL,
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
