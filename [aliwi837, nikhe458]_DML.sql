/* How many books has been loaned during year 2021 */
SELECT YEAR (LL.Date_out) AS year,
       COUNT (*) AS Literature_Loans
  FROM Literature_Loans AS LL
 WHERE YEAR (LL.Date_out) = 2021
 GROUP BY LL.Date_out;
 
/* How many artifact loans does a specific person have? */
SELECT P.[Name],
       A.Personal_ID,
       COUNT (P.Personal_ID)  AS 'Amount'
  FROM Person AS P
       INNER JOIN Artifact_Loan AS A
       ON P.Personal_ID = A.Personal_ID
 WHERE A.Personal_ID LIKE '19881012-1047'
 GROUP BY P.Name, A.Personal_ID
 ORDER BY 'Amount' DESC;

/* How many artifacts has been found during digs in LKPG? */
SELECT D.Dig_id,
       D.Dig_location,
       COUNT (A.Item_Nr) AS 'Amount'
  FROM Dig AS D
       INNER JOIN Artifact AS A
       ON D.Dig_id = A.Dig_ID
 WHERE Dig_location ='LKPG'
 GROUP BY D.Dig_id, D.Dig_location
HAVING COUNT(A.Item_Nr) > 0
 ORDER BY 'Amount' DESC;

/* Which book loans haven't been returned in time? */
SELECT P.[Name],
       L.Overdue,
       COUNT (P.Personal_ID)  AS 'Amount'
  FROM Person AS P
       INNER JOIN Literature_Loan AS L
       ON P.Personal_ID = L.Personal_ID
 WHERE L.Date_in > L.Overdue
 GROUP BY P.Name, L.Overdue
 ORDER BY 'Amount' DESC;
