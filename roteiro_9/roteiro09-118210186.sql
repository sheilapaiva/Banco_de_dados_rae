-- Roteiro 9 - Banco de Dados I
-- Banco: Company

-- QUESTAO 1

-- a) vw_dptmgr: contém apenas o número do departamento e o nome do gerente;

CREATE VIEW vw_dptmgr
AS SELECT e.dno, e.fname
FROM department AS dp, employee AS e
WHERE dp.mgrssn=e.ssn;

-- b) vw_empl_houston: contém o ssn e o primeiro nome dos empregados com endereço em Houston;

CREATE VIEW vw_empl_houston
AS SELECT e.ssn, e.fname
FROM employee AS e
WHERE e.address LIKE '%Houston%';

-- c) vw_deptstats: contém o número do departamento, o nome do departamento e o número de funcionários que trabalham no departamento;

CREATE VIEW vw_deptstats
AS SELECT dp.dnumber, dp.dname, COUNT(*) AS num_employee
FROM (works_on AS w INNER JOIN project AS p ON (p.number = w.pno) INNER JOIN department AS dp ON (p.dnum = dp.dnumber)
GROUP BY dp.dnumber;

-- d) vw_projstats: contém o id do projeto e a quantidade de funcionários que trabalham no projeto;

CREATE VIEW vw_projstats
AS SELECT p.pnumber, COUNT(*) AS num_employee
FROM (works_on AS w INNER JOIN project AS p ON (p.pnumber=w.pno))
GROUP BY p.pnumber;

-- QUESTAO 2
-- a)
SELECT * FROM vw_dptmgr;
-- b)
SELECT * FROM vw_empl_houston;
-- c)
SELECT * FROM vw_deptstats;
-- d)
SELECT * FROM vw_projstats;

-- QUESTAO 3
-- a)
DROP VIEW vw_dptmgr;
-- b)
DROP VIEW vw_empl_houston;
-- c)
DROP VIEW vw_deptstats;
-- d)
DROP VIEW vw_projstats;

-- QUESTAO 4

CREATE OR REPLACE FUNCTION check_age(e_ssn CHAR(7)) 
RETURNS VARCHAR AS $$
DECLARE
    e_idade INTEGER;
    retorno VARCHAR;
BEGIN
	SELECT date_part("year",age(bdate)) INTO e_idade
    FROM employee AS e
    WHERE e_ssn = e.ssn;
    IF (e_idade >= 50) THEN retorno := "SENIOR";
    ELSEIF (e_idade < 50 AND e_idade >= 0) THEN retorno := "YOUNG";
    ELSEIF (e_idade IS NULL) THEN retorno := "UNKNOWN";
    ELSE retorno := "INVALID";
	END IF;
    RETURN retorno;
END;
$$ LANGUAGE plpgsql;

-- QUESTAO 5

CREATE OR replace FUNCTION check_mgr() RETURNS trigger AS $check_mgr$
    DECLARE
        e_dno INTEGER;
        e_age INTEGER;
        e_supervisee employee%ROWTYPE;
    BEGIN
        SELECT dno INTO e_dno
        FROM employee
        WHERE ssn = new.mgrssn;
        SELECT * INTO e_supervisee
        FROM employee
        WHERE new.mgrssn = superssn;
        SELECT date_part("year",age(bdate)) INTO e_age
        FROM employee
        WHERE ssn = new.mgrssn;
        IF new.dnumber != e_dno THEN RAISE EXCEPTION 'manager must be a department''s employee';
        END IF;
        IF e_age < 50 THEN RAISE EXCEPTION 'manager must be a SENIOR employee';
        END IF;
        IF e_supervisee IS NULL THEN RAISE EXCEPTION 'manager must have supervisees';
        END IF;
        RETURN null;
    END;
$check_mgr$ LANGUAGE plpgsql;

CREATE TRIGGER check_mgr BEFORE INSERT OR UPDATE ON department
    FOR EACH ROW EXECUTE PROCEDURE check_mgr();