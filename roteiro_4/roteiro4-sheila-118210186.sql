-- Roteiro 4 - Banco de Dados I
-- Banco: Company

--Q1
SELECT * FROM department;

--Q2
SELECT * FROM dependent;

--Q3
SELECT * FROM dept_locations;

--Q4
SELECT * FROM employee;

--Q5
SELECT * FROM project;

--Q6
SELECT * FROM works_on;

--Q7
SELECT fname, lname FROM employee WHERE sex = 'M';

--Q8
SELECT fname FROM employee WHERE superssn is null;

--Q9
SELECT e.fname, s.fname 
FROM employee AS e, employee AS s
WHERE e.superssn = s.ssn;

--Q10
SELECT e.fname 
FROM employee AS e, employee AS s
WHERE e.superssn = s.ssn AND s.fname = 'Franklin';

--Q11
SELECT dname, dlocation
FROM department AS d, dept_locations AS dl
WHERE d.dnumber = dl.dnumber;

--Q12
SELECT dname
FROM department AS d, dept_locations AS dl
WHERE d.dnumber = dl.dnumber AND dl.dlocation LIKE 'S%';

--Q13
SELECT e.fname, e.lname, dependent_name
FROM employee AS e, dependent AS d
WHERE e.ssn = d.essn;

--Q14
SELECT fname || ' ' || lname AS full_name, salary
FROM employee AS e
WHERE e.salary >= 50000;

--Q15
SELECT pname, dname
FROM project AS p, department AS d
WHERE p.dnum = d.dnumber;

--Q16
SELECT pname, fname
FROM project AS p, department AS d, employee AS e
WHERE p.dnum = d.dnumber AND p.pnumber > 30 AND d.mgrssn = e.ssn;

--Q17
SELECT pname, fname
FROM project AS p, department AS d, employee AS e
WHERE d.dnumber = e.dno AND p.dnum = d.dnumber;

--Q18
SELECT fname, dependent_name, relationship
FROM project AS p, department AS d, employee AS e, dependent dp
WHERE p.pnumber = 91 AND p.dnum = d.dnumber AND d.dnumber = e.dno AND e.ssn = dp.essn;
