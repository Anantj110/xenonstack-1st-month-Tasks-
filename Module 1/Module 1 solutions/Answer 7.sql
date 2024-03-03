SELECT S.sname, E.dname
FROM enroll AS E
JOIN course AS C
ON E.cno = C.cno
JOIN student AS S 
ON S.sid = E.sid
WHERE C.cname IN ('College Geometry 1', 'College Geometry 2')