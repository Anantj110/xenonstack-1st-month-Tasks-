-- Print the names of professors who work in departments that have fewer than 50 PhD
-- students.

SELECT *
FROM prof AS P
RIGHT JOIN dept AS D
ON P.dname = D.dname
WHERE D.numphds < 50;