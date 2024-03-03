SELECT dname, sectno
FROM enroll
GROUP BY dname, sectno
HAVING COUNT(dname) > 6