SELECT E.cno, E.sectno, AVG(S.gpa)
FROM enroll AS E
JOIN student AS S
ON E.sid = S.sid
GROUP BY E.dname, E.cno, E.sectno
HAVING E.dname = 'Computer Sciences'