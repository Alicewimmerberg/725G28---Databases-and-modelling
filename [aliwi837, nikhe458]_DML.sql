

-- Hur många böcker har lånats mellan X och Y?

SELECT YEAR (LL.Date_out) AS year ,COUNT (*) AS Literature_Loans
FROM Literature_Loans AS LL
WHERE YEAR (LL.Date_out) = 2021
GROUP BY LL.Date_out;
 

-- Hur många artifactlån har en specifik person?

SELECT P.Name, A.Personal_ID, COUNT (P.Personal_ID)  AS 'Amount'
FROM Person AS P
    INNER JOIN Artifact_Loan AS A
ON P.Personal_ID = A.Personal_ID
WHERE A.Personal_ID LIKE '19881012-1047'
GROUP BY P.Name, A.Personal_ID
ORDER BY 'Amount' DESC;


/*
  SELECT P.Personal_ID, P.Name, COUNT (P.Personal_ID) AS 'count'
  FROM Person AS P
  INNER JOIN Artifact_Loan as A
  ON P.Personal_ID = A.Personal_ID
  GROUP BY P.Personal_ID, P.Name
  HAVING COUNT (P.Personal_ID) LIKE '19881012-1047'
  ORDER BY 'count' DESC; 
  */

-- Hur många artifakter har funnits i LKPG totalt?

SELECT D.Dig_id, D.Dig_location, COUNT (A.Item_Nr) AS 'Amount'
FROM Dig AS D 
INNER JOIN Artifact AS A
ON D.Dig_id = A.Dig_ID
WHERE Dig_location ='LKPG'
GROUP BY D.Dig_id, D.Dig_location
HAVING COUNT(A.Item_Nr) > 0
ORDER BY 'Amount' DESC;

-- Vilka boklån har overdues 
-- COUNT GROUP BY

SELECT P.Name, L.Overdue, COUNT (P.Personal_ID)  AS 'Overdusse'
FROM Person AS P
    INNER JOIN Literature_Loan AS L
ON P.Personal_ID = L.Personal_ID
WHERE L.Date_in > L.Overdue
GROUP BY P.Name, L.Overdue
ORDER BY 'Overdusse' DESC;
