DROP database Team2;
Create database Team2;
use Team2;

create table User
(userId int PRIMARY KEY AUTO_INCREMENT,
email varchar(255),
password varchar(255),
userType varchar(255),
firstName varchar(255),
lastName varchar(255),
phoneNumber varchar(255));

INSERT INTO `Team2`.`User`
(
`email`,
`password`,
`userType`,
`firstName`,
`lastName`,
`phoneNumber`)
VALUES
('yeseul@test.com',
'123','Writer','Yeseul','Jang','1234567890' );


create table Payment(
paymentId int PRIMARY KEY AUTO_INCREMENT,
userId int not null,
cardType varchar(255),
nameOnCard varchar(255),
cardNumber varchar(255),
expiryDate varchar(255),
cvc varchar(255),
country varchar(255),
zipCode varchar(255),
totalPrice varchar(255),
 FOREIGN KEY(userId) REFERENCES User(userId));
 
 create table Book
 (bookId int PRIMARY KEY AUTO_INCREMENT,
 userId int not null,
 title  varchar(255),
 genre  varchar(255),
  FOREIGN KEY(userId) REFERENCES User(userId));
 
create table Story(
storyId int PRIMARY KEY AUTO_INCREMENT,
bookId int not null,
subTitle varchar(255),
location varchar(255),
note longblob,
estimatedTime varchar(255),
 FOREIGN KEY(bookId) REFERENCES Book(bookId));
 
create table BookCharacter(
charactertId int PRIMARY KEY AUTO_INCREMENT,
characterName varchar(255),
age int(100),
appereance varchar(255));

create table Story_BookCharacter(
storyId  int not null,
charactertId int not null,
FOREIGN KEY(storyId) REFERENCES Story(storyId),
FOREIGN KEY(charactertId) REFERENCES BookCharacter(charactertId));
 
 
---------------------------------------------------- Kyungjin (2019-11-07)

create table BookLocation(
locationId int PRIMARY KEY AUTO_INCREMENT,
locationName varchar(255),
description longblob
);

create table Story_BookLocation(
storyId  int not null,
locationId int not null,
FOREIGN KEY(storyId) REFERENCES Story(storyId),
FOREIGN KEY(locationId) REFERENCES BookLocation(locationId));

 INSERT INTO `Team2`.`User`
(
`email`,
`password`,
`userType`,
`firstName`,
`lastName`,
`phoneNumber`)
VALUES
('kj@g.com',
'123','Writer','Kyungjin','Jeong','1234567890' );

INSERT INTO BOOK VALUES(1, 2, "The Little Prince", "Novel");
INSERT INTO BOOK VALUES(2, 2, "The Lord of the Rings", "Fantasy");
INSERT INTO BOOK VALUES(3, 2, "Harry Potter and the Philosopher's Stone", "Fantasy");
INSERT INTO BOOK VALUES(4, 1, "The Lion, the Witch and the Wardrobe", "Fantasy");

ALTER TABLE Story CHANGE COLUMN `subTitle` `chapterTitle` VARCHAR(255);
ALTER TABLE Story DROP COLUMN `location`;


---------------------------------------------------- Kyungjin (2019-11-08)
DROP TABLE Story_BookCharacter;
DROP TABLE Story_BookLocation;
DROP TABLE BookCharacter;
DROP TABLE BookLocation;
-- DROP TABLE Story_Character;
-- DROP TABLE `Character`;


create table BookCharacter(
characterId int PRIMARY KEY AUTO_INCREMENT,
name varchar(255),
age int(100),
appereance varchar(255),
bookId int not null,
FOREIGN KEY(bookId) REFERENCES Book(bookId)
);

create table Story_BookCharacter(
storyId  int not null,
characterId int not null,
FOREIGN KEY(storyId) REFERENCES Story(storyId),
FOREIGN KEY(characterId) REFERENCES BookCharacter(characterId));
 

create table Location(
locationId int PRIMARY KEY AUTO_INCREMENT,
name varchar(255),
description longblob,
bookId int not null,
FOREIGN KEY(bookId) REFERENCES Book(bookId)
);

create table Story_Location(
storyId  int not null,
locationId int not null,
FOREIGN KEY(storyId) REFERENCES Story(storyId),
FOREIGN KEY(locationId) REFERENCES Location(locationId));

INSERT INTO Location Values(1, 'Centennial College Library L3-22', '1 table and 8 chairs', 1);
INSERT INTO Location Values(2, 'Centennial College Library L3-24', '1 table and 8 chairs', 1);
INSERT INTO Location Values(3, 'Centennial College Library L3-26', '1 table and 8 chairs', 1);

ALTER TABLE Location CHANGE COLUMN `description` `description` Text;

INSERT INTO BookCharacter VALUES (1, 'Kyungjin', 20, 'black hair', 1);
INSERT INTO BookCharacter VALUES (2, 'Yeseul', 20, 'black hair and brown eyes', 1);


ALTER TABLE Story CHANGE COLUMN `note` `note` Text;

ALTER TABLE Story ADD COLUMN created_at DATETIME;




DELETE FROM Story_Location WHERE storyId >= 0;
DELETE FROM Story_BookCharacter WHERE storyId >= 0;
DELETE FROM Story WHERE storyId >= 0;

SELECT * FROM Story;
SELECT * FROM Story_Location;
SELECT * FROM Story_BookCharacter;



---------------------------------------------------- Megan (2019-11-24)
ALTER TABLE User ADD COLUMN aboutUser Text;

---------------------------------------------------- Fu (2019-12-1)
ALTER TABLE Payment ADD COLUMN bookId int;


---------------------------------------------------- Megan (2019-12-01)
ALTER TABLE Book ADD COLUMN bookDescription Text;


