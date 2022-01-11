
SELECT * 
FROM Literature_Loans;

SELECT * 
FROM List_Of_Loaners;

SELECT * 
FROM Artifact_Loans;


-- Hur många böcker har lånats mellan X och Y?
--GROUP BY WHERE

SELECT YEAR (LL.Date_out) AS year ,COUNT (*) AS Literature_Loans
FROM Literature_Loans AS LL
WHERE YEAR (LL.Date_out) = 2021
GROUP BY LL.Date_out;


 

-- Hur många lån har en specifik person?
-- WHERE gorup by
--I´COUNT
-- order by

SELECT L.Personal_ID, A.Display_Location
FROM Literature_Loan AS L
INNER JOIN Artifact_Loan AS A
ON L.Personal_ID = A.Personal_ID
INNER JOIN Slide_Loan AS S
ON A.Personal_ID = S.Personal_ID
order BY L.Personal_ID;

-- Hur många artifakter har funnits på plats X?
--SUM WHERE och gruoup by



-- Vilka lån har overdues och hur länge sedan skulle de ha vart återlämnade?
-- COUNT GROUP BY
