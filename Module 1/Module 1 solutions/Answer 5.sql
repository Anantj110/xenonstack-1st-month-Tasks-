SELECT S.sname, E.sid, COUNT(E.sectno)
FROM enroll AS E
JOIN student AS S
ON S.sid = E.sid
GROUP BY S.sname, E.sid
ORDER BY COUNT(E.sectno) DESC
LIMIT 1