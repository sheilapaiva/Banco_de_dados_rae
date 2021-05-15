--Q1
SELECT COUNT(*)
FROM employee AS e
WHERE e.sex = 'F';

--Q2
SELECT AVG(salary)
FROM employee AS e
WHERE e.sex = 'M' AND e.address LIKE '%TX';

--Q3
SELECT superssn AS ssn_supervisor, COUNT(*) AS qtd_supervisionados
FROM employee
GROUP BY superssn ORDER BY COUNT(*);

--Q4
SELECT s.fname AS nome_supervisor, COUNT(*) AS qtd_supervisionados
FROM (employee AS e JOIN employee AS s ON e.superssn = s.ssn)
GROUP BY s.fname
ORDER BY COUNT(*);

--Q5
SELECT s.fname AS nome_supervisor, COUNT(*) AS qtd_supervisionados
FROM (employee AS e LEFT OUTER JOIN employee AS s ON e.superssn = s.ssn) 
GROUP BY s.fname ORDER BY COUNT(*);

--Q6
SELECT MIN(resul.COUNT) AS qtd 
FROM (SELECT COUNT(*) FROM works_on GROUP BY pno) AS resul; 

--Q7
SELECT pno AS num_projeto, qtd AS qtd_func
FROM ((SELECT pno, COUNT(*) FROM works_on GROUP BY pno) AS pnc JOIN
      (SELECT MIN(COUNT) AS qtd FROM 
      (SELECT COUNT(*) FROM works_on GROUP BY pno) p) AS minimo ON pnc.COUNT = minimo.qtd);

--Q8
SELECT p.pnumber AS num_proj, AVG(e.salary) as media_sal
FROM project AS p JOIN works_on AS w ON (pnumber = pno) JOIN employee AS e ON (e.ssn = w.essn) 
GROUP BY num_proj
ORDER BY num_proj;

-- Q9
SELECT p.pnumber AS proj_num, p.pname AS proj_nome, AVG(e.salary) AS media_sal
FROM project AS p JOIN works_on AS w ON (pnumber = pno) JOIN employee AS e ON (e.ssn = w.essn) 
GROUP BY proj_num 
ORDER BY proj_num;

--  Q10
SELECT e.fname, e.salary 
FROM employee AS e 
WHERE e.salary > ALL (SELECT s.salary FROM works_on AS w JOIN employee AS s ON (s.ssn = w.essn) WHERE w.pno = 92);

-- Q11
SELECT e.ssn, COUNT(*) AS qtd_proj 
FROM employee AS e FULL OUTER JOIN works_on w ON (e.ssn = w.essn) 
GROUP BY e.ssn 
ORDER BY qtd_proj;

--Q12
SELECT pno AS num_proj, COUNT AS qtd_func
FROM (SELECT pno, COUNT(*) FROM employee AS e LEFT OUTER JOIN works_on AS w ON (w.essn = e.ssn) 
GROUP BY pno) AS resul
WHERE resul.count < 5
ORDER BY qtd_func;

--Q13
SELECT fname 
FROM employee AS e , project AS p, works_on AS w 
WHERE (e.ssn = w.essn) AND (p.pnumber = w.pno) AND p.plocation = 'Sugarland' 
AND EXISTS(SELECT pname FROM dependent AS d WHERE (e.ssn = d.essn));  

--Q14
SELECT dname 
FROM department AS d 
WHERE NOT EXISTS(SELECT * FROM project AS p WHERE p.dnum = dnumber);

--Q15
SELECT DISTINCT fname, lname 
FROM employee AS e, works_on 
WHERE essn = ssn AND ssn <> '123456789' 
AND NOT EXISTS ((SELECT pno FROM works_on WHERE essn = '123456789')
EXCEPT(SELECT pno FROM works_on WHERE essn = e.ssn));