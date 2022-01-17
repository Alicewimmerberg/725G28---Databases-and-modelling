

/* DELETE */

SELECT * FROM Artifact;

DELETE FROM Artifact
 WHERE Item_Nr = 31;


SELECT * FROM Artifact;

UPDATE Artifact
   SET Location_Found = 'GBG'
 WHERE Location_Found = 'UME?';

SELECT * FROM Artifact;
    

--DROP PROCEDURES / TRIGGERS
--CHECKLISTA:


--DROP PROCEDURE / TRIGGERS
--DROP VIEWS
--DROP TABLES

/*DROP VIEWS*/
DROP VIEW IF EXISTS List_Of_Loaners;
DROP VIEW IF EXISTS Artifact_List;
DROP VIEW IF EXISTS Slide_List;
DROP VIEW IF EXISTS Literature_Loans;
DROP VIEW IF EXISTS Artifact_Loans;

/*DROP TABLES*/
DROP TABLE IF EXISTS Literature, Slide, Artifact; -- Level 2
DROP TABLE IF EXISTS Literature_Loan, Artifact_Loan, Copy_Of_Journal, Dig, Slide_Loan; --Level 1
DROP TABLE IF EXISTS Person, Archeological_Journal; -- Level 0





