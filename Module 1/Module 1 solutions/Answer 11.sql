SELECT M.dname, AVG(S.gpa)
FROM student AS S
JOIN major AS M
ON S.sid = M.sid
WHERE S.gpa < 1.0
GROUP BY M.dname