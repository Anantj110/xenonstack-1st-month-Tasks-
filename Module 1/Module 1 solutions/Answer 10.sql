SELECT MAX(S.age)-MIN(S.age) AS age_difference
FROM student AS S
JOIN major AS M
ON M.sid = S.sid
WHERE M.dname = 'Computer Sciences'