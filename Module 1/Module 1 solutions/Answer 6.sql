SELECT M.dname
FROM major AS M
JOIN student AS S
ON M.sid = S.sid
WHERE S.age < 18