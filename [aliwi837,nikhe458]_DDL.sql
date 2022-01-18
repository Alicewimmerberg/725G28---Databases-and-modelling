--CHECKLISTA:
--DROP PROCEDURES / TRIGGERS
--CREATE PROCEDURES / TRIGGERS
/*INSERT*/
------------------------------------------------------------------------------------------------------------------------------
--DROP PROCEDURES / TRIGGERS
--DROP PROCEDURE IF EXISTS Add_Copy_Of_Journal;

/*DROP TABLES*/
/*Drop level 2 */
DROP TABLE IF EXISTS Literature, Slide, Artifact; 
/*Drop level 1 */
DROP TABLE IF EXISTS Literature_Loan, Artifact_Loan, Copy_Of_Journal, Dig, Slide_Loan; 
/*Drop level 0 */
DROP TABLE IF EXISTS Person, Archeological_Journal; 

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
       [Role]                   VARCHAR(20)           NOT NULL
       
);
/*Level 0*/
CREATE TABLE Archeological_Journal (
       PRIMARY KEY(Title),
       Title              VARCHAR(50)                       NOT NULL,
	   Author             VARCHAR(40)                       NOT NULL,
       Shelf_nr           INT                               NULL,
       Publication_date   DATE                              NOT NULL
);
/*Level 1*/
CREATE TABLE Dig (
       PRIMARY KEY  (Dig_id),
       Dig_id                INT                            NOT NULL,
       Dig_location          VARCHAR(20)                    NOT NULL,
       [Date]                DATE                           NOT NULL
 
);
/*Level 1*/
CREATE TABLE Copy_Of_Journal (
       PRIMARY KEY(Title, Personal_ID),
       Title                           VARCHAR(50),  
       Personal_ID                     VARCHAR(13),  
 
       FOREIGN KEY  (Title)
       REFERENCES    Archeological_journal(Title),
       FOREIGN KEY  (Personal_ID)
       REFERENCES    Person(Personal_ID)
);
/*Level 1*/
CREATE TABLE Literature_Loan (
       PRIMARY KEY(L_Loan_ID),
       L_Loan_ID              INT           IDENTITY(1,1)   NOT NULL,                              
       Personal_ID            VARCHAR(13)                   NOT NULL,  
       Date_out               DATE                          NOT NULL,
       Date_in                DATE                          NULL,
       Overdue                DATE                          NULL,

       FOREIGN KEY (Personal_ID)
       REFERENCES   Person(Personal_ID)
);
/*level 1*/
CREATE TABLE Slide_Loan (
       PRIMARY KEY(S_Loan_ID),
       S_Loan_ID              INT           IDENTITY(1,1)   NOT NULL,
       Personal_ID            VARCHAR(13)                   NOT NULL,    
       Date_out               DATE                          NOT NULL,
       Date_in                DATE                          NULL,    
       Overdue                DATE                          NULL,

       FOREIGN KEY    (Personal_ID)
       REFERENCES      Person(Personal_ID),
);
/*level 1*/
CREATE TABLE Artifact_Loan (
       PRIMARY KEY(A_Loan_ID),
       A_Loan_ID              INT           IDENTITY(1,1)   NOT NULL,
       Personal_ID            VARCHAR(13)                   NOT NULL,     
       Date_out               DATE                          NOT NULL,
       Date_in                DATE                          NULL,
       Display_Location       VARCHAR(25)                   NOT NULL,

       FOREIGN KEY    (Personal_ID)
       REFERENCES      Person(Personal_ID)
);
/*Level 2*/ 
CREATE TABLE Literature (
       PRIMARY KEY(Unique_ID),
       Unique_ID              VARCHAR(10)                   NOT NULL,
       L_Loan_ID              INT                           NULL,
       Title                  VARCHAR(50)                   NOT NULL,
       Author                 VARCHAR(40)                   NOT NULL,
       Publication_date       DATE                          NOT NULL,
 
       FOREIGN KEY  (L_Loan_ID)
       REFERENCES    Literature_Loan(L_Loan_ID)
);
/*Level 2*/
CREATE TABLE Slide (
       PRIMARY KEY(Slide_Nr),
       Slide_Nr              INT                            NOT NULL,
       S_Loan_ID             INT                            NULL,   
       [Description]         TEXT                           NOT NULL,
       [Subject]             VARCHAR(20)                    NOT NULL,

       FOREIGN KEY    (S_Loan_ID)
       REFERENCES      Slide_Loan(S_Loan_ID)
);
/*Level 2*/
CREATE TABLE Artifact (
       PRIMARY KEY(Item_Nr),
       Item_Nr              INT                             NOT NULL,
       Dig_ID               INT                             NOT NULL,    
       A_Loan_ID            INT                             NULL,    
	   Personal_ID          VARCHAR(13)                     NOT NULL,
       [Description]        TEXT                            NOT NULL,
       Date_Found           DATE                            NOT NULL,
       Location_Found       VARCHAR(25)                     NOT NULL,
       Shelf_Nr             INT                             NULL,
       Grid                 VARCHAR(15)                     NOT NULL,
       Depth                INT                             NOT NULL,

       FOREIGN KEY    (Dig_ID)
       REFERENCES      Dig(Dig_ID),
       FOREIGN KEY    (A_Loan_ID)
       REFERENCES      Artifact_Loan(A_Loan_ID),
	   FOREIGN KEY    (Personal_ID)
	   REFERENCES      Person(Personal_ID)
);
/*VYER*/

/* List of employees. */
GO
CREATE VIEW List_Of_Loaners
       AS SELECT Personal_ID, [Name]
  FROM Person;
GO
/* List of artifacts. */
GO
CREATE VIEW Artifact_List
       AS SELECT Item_Nr, Dig_ID,  [Description], Date_Found, Location_Found, Grid, Depth, A_Loan_ID
  FROM Artifact;
GO
 
 /* List of literature. */
 GO
 CREATE VIEW Literature_Loans
        AS SELECT  Personal_ID, Date_out, Date_in, Overdue
   FROM Literature_Loan;
 GO
/* List of slides. */
GO
CREATE VIEW Slide_List
       AS SELECT Slide_Nr, [Description], [Subject], S_Loan_ID
  FROM Slide;
GO
/* List with artifact loans. */
GO
CREATE VIEW Artifact_Loans
       AS SELECT Personal_ID, Date_out, Date_in
  FROM Artifact_Loan;
GO


/*INSERT*/

/* Person */
INSERT INTO Person (Personal_ID, [Name], Phone, [Role])
       VALUES ('19991219-1047','Alice', '0738323401', 'Student'),
              ('19980313-1047','Niki', '0738553401', 'Employee' ),
              ('19770422-1047','Truls', '0737650981', 'Employee'),
              ('19881012-1047','Linus', '0738511101', 'Employee'),
              ('19951024-1047','Carl', '0738511101', 'Employee'),
              ('19901010-1047','My', '0738511101', 'Employee'),
              ('19921004-1047','Lana', '0738511101', 'Employee'),
              ('19941007-1047','Loke', '0738511101', 'Employee'),
              ('19941018-1047','Frej', '0738511101', 'Employee'),
              ('19911011-1047','Cleo', '0732020401', 'Student');

/* Archeological_Journal */
INSERT INTO Archeological_Journal (Title, Author, Shelf_nr, Publication_date)
       VALUES ('Boken om Niki', 'Paul Smith', NULL , '2001-01-21'),
              ('The Journal of Archaeological Science, vol 1', 'Paul Smith', NULL, '2001-01-21'),
              ('The Journal of Archaeological Science, vol 2', 'Paul Smith', 3, '2001-02-21'),
              ('The Journal of Archaeological Science, vol 3', 'Paul Smith', 4, '2001-03-21'),
              ('The Journal of Archaeological Science, vol 4', 'Paul Smith', 5, '2001-04-21'),
              ('The Journal of Archaeological Science, vol 5', 'Paul Smith', 5, '2001-05-21'),
              ('The Journal of Archaeological Science, vol 6', 'Paul Smith', 5, '2001-06-21');

/* Copy_Of_Journal */
INSERT INTO Copy_Of_Journal (Title, Personal_ID)
       VALUES ('Boken om Niki', '19911011-1047'), --Cleo
              ('The Journal of Archaeological Science, vol 4', '19911011-1047'); --Cleo
/* Dig */
INSERT INTO Dig( Dig_id, Dig_location, [Date])
       VALUES (  5, 'LKPG',   '2019-03-07'), --Niki
              ( 13, 'UME�',   '2021-12-07'), --Niki
              ( 20, 'OSLO',   '2021-12-07'),--Loke
              ( 22, 'STHLM',  '2021-12-07'),--Loke
              ( 25, 'LKPG',   '2021-12-07'), --Lana
              ( 32, 'KALMAR', '2021-12-07');--Truls
/* Literature_Loan */ 
INSERT INTO Literature_Loan ( Personal_ID, Date_out, Date_in, Overdue)
       VALUES ( '19991219-1047', '2019-07-07', '2022-01-06', '2022-01-05'), --Alice
              ('19980313-1047', '2020-09-07', '2022-01-06', '2022-01-05'), --Niki
              ('19951024-1047', '2021-10-07', '2022-01-01', '2022-01-05'), --My
              ('19941018-1047', '2021-12-07', '2022-01-01', '2022-01-05'), --Frej
              ('19911011-1047', '2022-01-01', '2022-01-01', '2022-01-05'); --Cleo
/* Slide_Loan */
INSERT INTO Slide_Loan (Personal_ID, Date_out, Date_in, Overdue)
       VALUES ( '19991219-1047', '2021-01-05', '2021-03-02', '2021-01-10'), --Alice
              ( '19951024-1047', '2021-01-05', '2021-03-02', '2021-01-10'), --Carl
              ( '19901010-1047', '2021-01-05', '2021-03-02', '2021-01-10'), --My
              ( '19901010-1047', '2021-01-05', '2021-03-02', '2021-01-10'), --My
              ( '19911011-1047', '2021-01-05', '2021-03-02', '2021-01-10'); --Cleo
/* Artifact_Loan */
INSERT INTO Artifact_Loan ( Personal_ID, Date_out, Date_in, Display_Location)
       VALUES ( '19881012-1047', '2021-05-06', '2021-06-05', 'Museum'),--M�ns
              ( '19881012-1047', '2021-05-06', '2021-06-05', 'Museum'),--M�ns
              ( '19991219-1047', '2021-05-06', '2021-06-05', 'Museum'),--Alice
              ( '19951024-1047', '2021-05-06', '2021-06-05', 'Museum'),--Carl
              ( '19951024-1047', '2021-05-06', '2021-06-05', 'Museum');--Carl
/* Literature */
INSERT INTO Literature (Unique_ID,  Title, Author, Publication_date, L_Loan_ID)
       VALUES ('2678',   'Boken om Niki', 'Alice Wimmerberg', '2021-10-12', 1),
              ('1091',   'Boken om Alice', 'Niki Hennings', '2021-11-12', 2),
              ('1315',  'Boken om stenar', 'Alice Wimmerberg', '2002-10-12', 3),
              ('1617',  'Boken om runor', 'Alice Wimmerberg', '1950-10-12', 4),
              ('1411',  'Boken om sten�ldern', 'Alice Wimmerberg', '1940-10-12', 5),
              ('1111',  'Boken om Vikingar', 'Alice Wimmerberg', '1980-10-12', null),
              ('2727',  'Boken om historisk arkitektur', 'Alice Wimmerberg', '2001-10-12', null);
/* Slide */
INSERT INTO Slide (Slide_Nr, [Description], [Subject], S_Loan_ID)
       VALUES ('01', 'Artifact slide', 'Animals',  1),
              ('02', 'Artifact slide', 'Animals',  2),
              ('03', 'Artifact slide', 'Animals',  3),
              ('04', 'Artifact slide', 'Buildings',  4),
              ('05', 'Artifact slide', 'Vikings',  5),
              ('06', 'Artifact slide', 'Vikings',  null),
              ('07', 'Artifact slide', 'Vikings',  null),
              ('08', 'Artifact slide', 'Buildings',  null),
              ('09', 'Artifact slide', 'Music',  null),
              ('10', 'Artifact slide', 'Music',  null),
              ('11', 'Artifact slide', 'Weapons',  null),
              ('12', 'Artifact slide', 'Weapons',  null),
              ('13', 'Artifact slide', 'Weapons',  null),
              ('14', 'Artifact slide', 'Weapons',  null),
              ('15', 'Artifact slide', 'Weapons',  null);
/* Artifact */
INSERT INTO Artifact (Item_Nr, Dig_ID, Personal_ID, [Description], Date_Found, Location_Found, Shelf_Nr, Grid, Depth, A_Loan_ID)
       VALUES (1, 5, '19991219-1047', 'En stor vas 1730-talet', '2019-03-07', 'LKPG', '1', '56', 10, 1), --L�n #1/ID 1, M�ns
              (2, 5, '19991219-1047', 'bla bla', '2019-03-07', 'LKPG', '2', '56', 78, null),
              (3, 5, '19991219-1047', 'bla bla', '2019-03-09', 'LKPG', '3', '56', 78, null),
              (4, 5, '19991219-1047', 'bla bla', '2019-03-11', 'LKPG', '4', '56', 78, null),
              (5, 5, '19991219-1047', 'bla bla', '2019-03-12', 'LKPG', '5', '56', 78, null),
              (6, 13, '19991219-1047', 'bla bla', '2021-05-07', 'UME�', '6', '56', 78, null),
              (7, 13, '19991219-1047', 'bla bla', '2021-05-07', 'UME�', '7', '56', 78, null),
              (8, 13, '19991219-1047', 'En gaffel- vikingatiden', '2021-05-07', 'UME�', '8', '56', 78, 2), --L�n #2, M�ns
              (9, 13, '19991219-1047', 'bla bla', '2021-05-07', 'UME�', '9', '56', 78, null),
              (10, 13, '19991219-1047', 'bla bla', '2021-05-07', 'UME�', '10', '56', 78, null),
              (11, 20, '19991219-1047', 'bla bla', '2021-05-07', 'OSLO', '11', '56', 78, null),
              (12, 20, '19991219-1047', 'bla bla', '2021-05-07', 'OSLO', '12', '56', 78, null),
              (13, 20, '19991219-1047', 'bla bla', '2021-05-07', 'OSLO', '13', '56', 78, null),
              (14, 20, '19991219-1047', 'bla bla', '2021-05-07', 'OSLO', '14', '56', 78, null),
              (15, 20, '19991219-1047', 'bla bla', '2021-05-07', 'OSLO', '15', '56', 78, null),
              (16, 20, '19991219-1047', 'bla bla', '2021-05-07', 'OSLO', '16', '56', 78, null),
              (17, 22, '19991219-1047', 'bla bla', '2021-05-07', 'STHLM', '17', '56', 20, null),
              (18, 22, '19991219-1047', 'bla bla', '2021-05-07', 'STHLM', '18', '56', 20, null),
              (19, 22, '19991219-1047', 'bla bla', '2021-05-07', 'STHLM', '19', '56', 20, null),
              (20, 22, '19991219-1047', 'bla bla', '2021-05-07', 'STHLM', '20', '56', 20, 3), --L�n #3, M�ns
              (21, 22, '19991219-1047', 'bla bla', '2021-05-07', 'STHLM', '21', '56', 20, null),
              (22, 22, '19991219-1047', 'bla bla', '2021-05-07', 'STHLM', '22', '56', 20, null),
              (23, 25, '19991219-1047', 'En trumma', '2021-05-07', 'LKPG', '23', '56', 78, 4), --L�n #4
              (24, 25, '19991219-1047', 'bla bla', '2021-05-07', 'LKPG', '24', '56', 78, null),
              (25, 25, '19991219-1047', 'bla bla', '2021-05-07', 'LKPG', '25', '56', 78, null),
              (26, 32, '19991219-1047', 'Keramik', '2021-05-07', 'KALMAR', '26', '56', 78, 5), --L�n #5
              (27, 32, '19991219-1047', 'bla bla', '2021-05-07', 'KALMAR', '27', '56', 78, null),
              (28, 32, '19991219-1047', 'bla bla', '2021-05-07', 'KALMAR', '28', '56', 78, null),
              (29, 32, '19991219-1047', 'bla bla', '2021-05-07', 'KALMAR', '29', '56', 78, null),
              (30, 32, '19991219-1047', 'bla bla', '2021-05-07', 'KALMAR', '30', '56', 78, null),
              (31, 32, '19991219-1047', 'test grej', '2021-05-07', 'KALMAR', '30', '56', 78, null);
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
