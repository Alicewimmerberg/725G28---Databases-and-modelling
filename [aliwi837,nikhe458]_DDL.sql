
   
--CHECKLISTA:
--DROP PROCEDURES / TRIGGERS
-- DROP VIEWS CHECK!
-- DROP TABLES CHECK!

--CREATE TABLES CHECK!
--CREATE VIEWS CHECK!
--CREATE PROCEDURES / TRIGGERS

--INSERT
------------------------------------------------------------------------------------------------------------------------------
--DROP PROCEDURES / TRIGGERS
DROP PROCEDURE IF EXISTS Add_Copy_Of_Journal;

/*DROP TABLES*/
DROP TABLE IF EXISTS Literature, Slide, Artifact; -- Level 2
DROP TABLE IF EXISTS Literature_Loan, Artifact_Loan, Copy_Of_Journal, Dig, Slide_Loan; --Level 1
DROP TABLE IF EXISTS Person, Archeological_Journal; -- Level 0

/*DROP VIEWS*/
DROP VIEW IF EXISTS List_Of_Loaners;
DROP VIEW IF EXISTS Artifact_List;
DROP VIEW IF EXISTS Slide_List;
DROP VIEW IF EXISTS Literature_Loans;
DROP VIEW IF EXISTS Artifact_Loans;


/*CREATE TABLES*/

/*LEVEL0*/
CREATE TABLE Person (
       PRIMARY KEY(Personal_ID),
       Personal_ID              VARCHAR(13)           NOT NULL,
       [Name]                   VARCHAR(32)           NOT NULL,
       Phone                    VARCHAR(16)           NOT NULL,
       [Role]                   VARCHAR(20)           NOT NULL,
       Loans                    INT,
);

/*Level 0*/
CREATE TABLE Archeological_Journal (
       PRIMARY KEY(Title),
       Title                     VARCHAR(50)                     NOT NULL,
       Shelf_nr                  INT                             NULL,
       Publication_date          DATE                            NOT NULL,
);

/*Level 1*/
CREATE TABLE Dig (
       PRIMARY KEY  (Dig_id),
       Dig_id                  INT                               NOT NULL,
       Personal_ID             VARCHAR(13)                       NOT NULL,
       Dig_location            VARCHAR(20)                       NOT NULL,
       Date                    DATE                              NOT NULL,
  
  FOREIGN KEY (Personal_ID)
  REFERENCES Person(Personal_ID)
);

/*Level 1*/
CREATE TABLE Copy_Of_Journal (
       PRIMARY KEY(Title, Personal_ID),
       Title                    VARCHAR(50),  
       Personal_ID              VARCHAR(13),  
  
  FOREIGN KEY(Title)
  REFERENCES Archeological_journal(Title),
  FOREIGN KEY (Personal_ID)
  REFERENCES Person(Personal_ID)
);


/*Level 1*/
CREATE TABLE Literature_Loan (
       PRIMARY KEY(L_Loan_ID),
       L_Loan_ID                  INT              IDENTITY(1,1)   NOT NULL,                              
       Personal_ID               VARCHAR(13)                      NOT NULL,  ---!
       Date_out                  DATE                             NOT NULL,
       Date_in                   DATE                             NOT NULL,
       Overdue                   DATE                             NOT NULL,

  FOREIGN KEY (Personal_ID)
  REFERENCES Person(Personal_ID)

);

/*level 1*/
CREATE TABLE Slide_Loan(
       PRIMARY KEY(S_Loan_ID),
       S_Loan_ID          INT                 IDENTITY(1,1)   NOT NULL,
       Personal_ID        VARCHAR(13)           NOT NULL,    --!
       Date_out           DATE                  NOT NULL,
       Date_in            DATE                  NOT NULL,
       Slide_Nr            INT                  NOT NULL,    
       Overdue            DATE                  NOT NULL,

FOREIGN KEY    (Personal_ID)
REFERENCES     Person(Personal_ID),

);

/*level 1*/
CREATE TABLE Artifact_Loan(
       PRIMARY KEY(A_Loan_ID),
       A_Loan_ID        INT    IDENTITY(1,1) NOT NULL,
       Personal_ID      VARCHAR(13)       NOT NULL,     --!
       Date_out         DATE      NOT NULL,
       Date_in          DATE      NOT NULL,
       Display_Location VARCHAR(25)   NOT NULL,

   FOREIGN KEY    (Personal_ID)
   REFERENCES     Person(Personal_ID)
);

/*Level 2*/ 
CREATE TABLE Literature (
       PRIMARY KEY(Unique_ID),
       Unique_ID                 VARCHAR(10),
       L_Loan_ID                   INT                NULL,
       Shelf_nr                  INT                             NULL,
       Title                     VARCHAR(50)                     NOT NULL,
       Author                    VARCHAR(40)                     NOT NULL,
       Publication_date          DATE                            NOT NULL,
  
  FOREIGN KEY(L_Loan_ID)
  REFERENCES Literature_Loan(L_Loan_ID)
);

/*Level 2*/
CREATE TABLE Slide(
       PRIMARY KEY(Slide_Nr),
       Slide_Nr          INT                   NOT NULL,
       S_Loan_ID         INT               NULL,   --!
       [Description]     TEXT   NOT NULL,
       [Subject]         VARCHAR(20)     NOT NULL,
       Shelf_Nr          INT  NOT NULL,

FOREIGN KEY    (S_Loan_ID)
REFERENCES     Slide_Loan(S_Loan_ID)
);



/*Level 2*/
CREATE TABLE Artifact(
       PRIMARY KEY(Item_Nr),
       Item_Nr         INT     NOT NULL,
       Dig_ID          INT      NOT NULL,    --!
       A_Loan_ID       INT      NULL,     --!
       [Description]   TEXT   NOT NULL,
       Date_Found      DATE    NOT NULL,
       Location_Found  VARCHAR(25)   NOT NULL,
       Shelf_Nr        INT  NOT NULL,
       Grid            VARCHAR(15)  NOT NULL,
       Depth           INT   NOT NULL,

FOREIGN KEY    (Dig_ID)
REFERENCES     Dig(Dig_ID),
FOREIGN KEY    (A_Loan_ID)
REFERENCES     Artifact_Loan(A_Loan_ID)
);

/*VYER*/


/*LISTA ÖVER ANSTÄLLDA*/
GO

CREATE VIEW List_Of_Loaners 
AS SELECT Personal_ID, [Name]
FROM Person;

GO

/*LISTA �VER ARTIFAKTER --- g�r n�gon join senare*/
GO

CREATE VIEW Artifact_List
AS SELECT Item_Nr, Dig_ID,  [Description], Date_Found, Location_Found, Shelf_Nr, Grid, Depth, A_Loan_ID
FROM Artifact;
GO

 
 /* lista över literatur */
 GO

 CREATE VIEW Literature_Loans
 AS SELECT  Personal_ID, Date_out, Date_in, Overdue
 FROM Literature_Loan;

 GO


/* LISTA ÖVER SLIDES --- g�r n�gon join senare*/
GO

CREATE VIEW Slide_List
AS SELECT Slide_Nr, [Description], [Subject], Shelf_Nr, S_Loan_ID
FROM Slide;
GO

/*LISTA ÖVER ARTIFACT LOANS  */
GO

CREATE VIEW Artifact_Loans
AS SELECT Personal_ID, Date_out, Date_in
FROM Artifact_Loan;

GO



/*INSERT*/


/*Person*/
INSERT INTO Person (Personal_ID, [Name], Phone, [Role])
     VALUES ('19991219-1047','Alice', '0738323401', 'Student'),
    	    ('19980313-1047','Niki', '0738553401', 'Employee' ),
	  	    ('19770422-1047','Truls', '0737650981', 'Employee'),
	  	    ('19881012-1047','M�ns', '0738511101', 'Employee'),
	        ('19951024-1047','Carl', '0738511101', 'Employee'),
	   	    ('19901010-1047','My', '0738511101', 'Employee'),
	   	    ('19921004-1047','Lana', '0738511101', 'Employee'),
	   	    ('19941007-1047','Loke', '0738511101', 'Employee'),
	   	    ('19941018-1047','Frej', '0738511101', 'Employee'),
	   	    ('19911011-1047','Cleo', '0732020401', 'Student');

/*Archeological_Journal*/
INSERT INTO Archeological_Journal (Title, Shelf_nr, Publication_date)
     VALUES ('Boken om Niki', NULL, '2001-01-21'),
            ('The Journal of Archaeological Science, vol 1', NULL, '2001-01-21'),
	        ('The Journal of Archaeological Science, vol 2', 3, '2001-02-21'),
	        ('The Journal of Archaeological Science, vol 3', 4, '2001-03-21'),
	        ('The Journal of Archaeological Science, vol 4', 5, '2001-04-21'),
	        ('The Journal of Archaeological Science, vol 5', 5, '2001-05-21'),
	        ('The Journal of Archaeological Science, vol 6', 5, '2001-06-21');


/*Copy_Of_Journal*/
INSERT INTO Copy_Of_Journal (Title, Personal_ID)
      VALUES ('Boken om Niki', '19911011-1047'), --Cleo
             ('The Journal of Archaeological Science, vol 4', '19911011-1047'); --Cleo

/*Dig*/
INSERT INTO Dig( Personal_ID, Dig_id, Dig_location, [Date])
      VALUES ( '19980313-1047',  5, 'LKPG',   '2019-03-07'), --Niki
             ( '19980313-1047', 13, 'UME�',   '2021-12-07'), --Niki
	         ( '19941007-1047', 20, 'OSLO',   '2021-12-07'),--Loke
	         ( '19941007-1047', 22, 'STHLM',  '2021-12-07'),--Loke
	         ( '19921004-1047', 25, 'LKPG',   '2021-12-07'), --Lana
	         ( '19770422-1047', 32, 'KALMAR', '2021-12-07');--Truls

/*Literature_Loan*/ 
INSERT INTO Literature_Loan ( Personal_ID, Date_out, Date_in, Overdue)
      VALUES ( '19991219-1047', '2021-07-07', '2022-01-01', '2022-01-05'), --Alice
             ('19980313-1047', '2021-09-07', '2022-01-01', '2022-01-05'), --Niki
	         ('19901010-1047', '2021-10-07', '2022-01-01', '2022-01-05'), --My
	         ('19941018-1047', '2021-12-07', '2022-01-01', '2022-01-05'), --Frej
	         ('19911011-1047', '2022-01-01', '2022-01-01', '2022-01-05'); --Cleo

/*Slide_Loan*/
INSERT INTO Slide_Loan (Personal_ID, Date_out, Date_in, Slide_Nr, Overdue)
      VALUES ( '19991219-1047', '2021-01-05', '2021-03-02', 5, '2021-01-10'), --Alice
             ( '19951024-1047', '2021-01-05', '2021-03-02', 5, '2021-01-10'), --Carl
      	     ( '19901010-1047', '2021-01-05', '2021-03-02', 5, '2021-01-10'), --My
      	     ( '19901010-1047', '2021-01-05', '2021-03-02', 5, '2021-01-10'), --My
      	     ( '19911011-1047', '2021-01-05', '2021-03-02', 5, '2021-01-10'); --Cleo

/*Artifact_Loan*/
INSERT INTO Artifact_Loan ( Personal_ID, Date_out, Date_in, Display_Location)
      VALUES ( '19881012-1047', '2021-05-06', '2021-06-05', 'Museum'),--M�ns
             ( '19881012-1047', '2021-05-06', '2021-06-05', 'Museum'),--M�ns
	         ( '19991219-1047', '2021-05-06', '2021-06-05', 'Museum'),--Alice
	         ( '19951024-1047', '2021-05-06', '2021-06-05', 'Museum'),--Carl
	         ( '19951024-1047', '2021-05-06', '2021-06-05', 'Museum');--Carl

/*Literature*/
INSERT INTO Literature (Unique_ID, Shelf_nr, Title, Author, Publication_date, L_Loan_ID)
      VALUES ('2678',  NULL , 'Boken om Niki', 'Alice Wimmerberg', '2021-10-12', 1),
             ('1091',     4 , 'Boken om Alice', 'Niki Hennings', '2021-11-12', 2),
	         ('1315',  NULL , 'Boken om stenar', 'Alice Wimmerberg', '2002-10-12', 3),
	         ('1617',  NULL , 'Boken om runor', 'Alice Wimmerberg', '1950-10-12', 4),
	         ('1411',  NULL , 'Boken om sten�ldern', 'Alice Wimmerberg', '1940-10-12', 5),
	         ('1111',    10 , 'Boken om Vikingar', 'Alice Wimmerberg', '1980-10-12', null),
             ('2727',  NULL , 'Boken om historisk arkitektur', 'Alice Wimmerberg', '2001-10-12', null);

/*Slide*/
INSERT INTO Slide (Slide_Nr, [Description], [Subject], Shelf_Nr, S_Loan_ID)
      VALUES ('01', 'Artifact slide', 'Animals', '5', 1),
             ('02', 'Artifact slide', 'Animals', '5', 2),
      	     ('03', 'Artifact slide', 'Animals', '5', 3),
       	     ('04', 'Artifact slide', 'Buildings', '32', 4),
	   	     ('05', 'Artifact slide', 'Vikings', '7', 5),
	   	     ('06', 'Artifact slide', 'Vikings', '7', null),
	   	     ('07', 'Artifact slide', 'Vikings', '7', null),
	   	     ('08', 'Artifact slide', 'Buildings', '32', null),
	   	     ('09', 'Artifact slide', 'Music', '16', null),
	   	     ('10', 'Artifact slide', 'Music', '16', null),
	   	     ('11', 'Artifact slide', 'Weapons', '15', null),
	   	     ('12', 'Artifact slide', 'Weapons', '15', null),
	   	     ('13', 'Artifact slide', 'Weapons', '15', null),
	   	     ('14', 'Artifact slide', 'Weapons', '15', null),
       	     ('15', 'Artifact slide', 'Weapons', '15', null);

/*Artifact*/
INSERT INTO Artifact (Item_Nr, Dig_ID,  [Description], Date_Found, Location_Found, Shelf_Nr, Grid, Depth, A_Loan_ID)
	  VALUES (1, 5,  'En stor vas fr�n 1730-talet', '2019-03-07', 'LKPG', '1', '56', 10, 1), --L�n #1/ID 1, M�ns
       	     (2, 5,  'bla bla', '2019-03-07', 'LKPG', '2', '56', 78, null),
	  	     (3, 5,  'bla bla', '2019-03-09', 'LKPG', '3', '56', 78, null),
	   	     (4, 5,  'bla bla', '2019-03-11', 'LKPG', '4', '56', 78, null),
	   	     (5, 5,  'bla bla', '2019-03-12', 'LKPG', '5', '56', 78, null),
	   	     (6, 13,  'bla bla', '2021-05-07', 'UME�', '6', '56', 78, null),
	   	     (7, 13,  'bla bla', '2021-05-07', 'UME�', '7', '56', 78, null),
	   	     (8, 13,  'Ett sv�rd fr�n vikingatiden', '2021-05-07', 'UME�', '8', '56', 78, 2), --L�n #2, M�ns
	   	     (9, 13,  'bla bla', '2021-05-07', 'UME�', '9', '56', 78, null),
	   	     (10, 13,  'bla bla', '2021-05-07', 'UME�', '10', '56', 78, null),
	   	     (11, 20,  'bla bla', '2021-05-07', 'OSLO', '11', '56', 78, null),
	   	     (12, 20,  'bla bla', '2021-05-07', 'OSLO', '12', '56', 78, null),
	   	     (13, 20,  'bla bla', '2021-05-07', 'OSLO', '13', '56', 78, null),
	   	     (14, 20,  'bla bla', '2021-05-07', 'OSLO', '14', '56', 78, null),
	   	     (15, 20,  'bla bla', '2021-05-07', 'OSLO', '15', '56', 78, null),
	   	     (16, 20,  'bla bla', '2021-05-07', 'OSLO', '16', '56', 78, null),
	   	     (17, 22,  'bla bla', '2021-05-07', 'STHLM', '17', '56', 20, null),
	   	     (18, 22,  'bla bla', '2021-05-07', 'STHLM', '18', '56', 20, null),
	   	     (19, 22,  'bla bla', '2021-05-07', 'STHLM', '19', '56', 20, null),
	   	     (20, 22,  'bla bla', '2021-05-07', 'STHLM', '20', '56', 20, 3), --L�n #3, M�ns
	   	     (21, 22,  'bla bla', '2021-05-07', 'STHLM', '21', '56', 20, null),
	   	     (22, 22,  'bla bla', '2021-05-07', 'STHLM', '22', '56', 20, null),
	   	     (23, 25,  'Ett fornnordiskt musikinstrument', '2021-05-07', 'LKPG', '23', '56', 78, 4), --L�n #4
	   	     (24, 25,  'bla bla', '2021-05-07', 'LKPG', '24', '56', 78, null),
	   	     (25, 25,  'bla bla', '2021-05-07', 'LKPG', '25', '56', 78, null),
	   	     (26, 32,  'Keramik', '2021-05-07', 'KALMAR', '26', '56', 78, 5), --L�n #5
	   	     (27, 32,  'bla bla', '2021-05-07', 'KALMAR', '27', '56', 78, null),
	   	     (28, 32,  'bla bla', '2021-05-07', 'KALMAR', '28', '56', 78, null),
	   	     (29, 32,  'bla bla', '2021-05-07', 'KALMAR', '29', '56', 78, null),
       	     (30, 32,  'bla bla', '2021-05-07', 'KALMAR', '30', '56', 78, null),
		     (31, 32,  'test grej', '2021-05-07', 'KALMAR', '30', '56', 78, null);

			
------------------------------------------DELETE (till senare)-----------------------------------------------------------------------------


--SELECT * FROM Artifact;

--DELETE FROM Artifact
--      WHERE Item_Nr = 31;


--SELECT * FROM Artifact;

--UPDATE Artifact
--   SET Location_Found = 'GBG'
--   WHERE Location_Found = 'UME�';

--   SELECT * FROM Artifact;

-- Det vi behöver göra här är att utveckla en proceduren och lägga till i tex copy of journal sedan skapa en inner join. I videon förklaras allt ganska bra. 
    

/*CREATE PROCEDURES / TRIGGERS*/

/*
GO


CREATE PROCEDURE Add_Copy_Of_Journal
      /* @Title       Parametrar @ sedan vilken data typ tex int*/
	   @Copy_nr INT
	   AS BEGIN
	      SELECT CONCAT('Metodkropp', ' ', @Copy_nr) AS 'Statement';
		INSERT INTO Copy_Of_Journal
		VALUES(@Copy_nr)
	GO;

	 END;
*/



