# Sorting-and-Grouping
CREATE TABLE EMPLOYEES (
                            EMP_ID CHAR(9) NOT NULL, 
                            F_NAME VARCHAR(15) NOT NULL,
                            L_NAME VARCHAR(15) NOT NULL,
                            SSN CHAR(9),
                            B_DATE DATE,
                            SEX CHAR,
                            ADDRESS VARCHAR(30),
                            JOB_ID CHAR(9),
                            SALARY DECIMAL(10,2),
                            MANAGER_ID CHAR(9),
                            DEP_ID CHAR(9) NOT NULL,
                            PRIMARY KEY (EMP_ID));
                            
  CREATE TABLE JOB_HISTORY (
                            EMPL_ID CHAR(9) NOT NULL, 
                            START_DATE DATE,
                            JOBS_ID CHAR(9) NOT NULL,
                            DEPT_ID CHAR(9),
                            PRIMARY KEY (EMPL_ID,JOBS_ID));
 
 CREATE TABLE JOBS (
                            JOB_IDENT CHAR(9) NOT NULL, 
                            JOB_TITLE VARCHAR(15) ,
                            MIN_SALARY DECIMAL(10,2),
                            MAX_SALARY DECIMAL(10,2),
                            PRIMARY KEY (JOB_IDENT));

CREATE TABLE DEPARTMENTS (
                            DEPT_ID_DEP CHAR(9) NOT NULL, 
                            DEP_NAME VARCHAR(15) ,
                            MANAGER_ID CHAR(9),
                            LOC_ID CHAR(9),
                            PRIMARY KEY (DEPT_ID_DEP));

CREATE TABLE LOCATIONS (
                            LOCT_ID CHAR(9) NOT NULL,
                            DEP_ID_LOC CHAR(9) NOT NULL,
                            PRIMARY KEY (LOCT_ID,DEP_ID_LOC));
SELECT * FROM EMPLOYEES;

SELECT * FROM JOB_HISTORY;

SELECT * FROM JOBS;

SELECT * FROM DEPARTMENTS;

SELECT * FROM LOCATIONS;

--- Query1 ---
SELECT F_NAME, L_NAME from EMPLOYEES
WHERE ADDRESS LIKE '%ELGIN,IL%';

--- Query2 ---
SELECT F_NAME, L_NAME from EMPLOYEES
WHERE B_DATE LIKE '%197%';

--- Query3 ---
select * from EMPLOYEES
where (SALARY BETWEEN 60000 and 70000)  and DEP_ID = 5 ;

--- Query4 ---
SELECT * from EMPLOYEES
ORDER BY DEP_ID;

--- Query5 ---
SELECT F_NAME, L_NAME, DEP_ID from EMPLOYEES
ORDER BY DEP_ID DESC, L_NAME DESC;

--- Query6 ---
SELECT DEP_ID, COUNT(DEP_ID)
AS COUNT FROM EMPLOYEES GROUP BY DEP_ID;

--- Query7 ---
SELECT DEP_ID, AVG(SALARY), COUNT(DEP_ID)
AS COUNT FROM EMPLOYEES GROUP BY DEP_ID;

--- Query8 ---
SELECT DEP_ID, AVG(SALARY) AS 'AVG_SALARY', COUNT(DEP_ID) 
AS 'NUM_EMPLOYEES' FROM EMPLOYEES GROUP BY DEP_ID;

--- Query9 ---
SELECT DEP_ID, AVG(SALARY) AS 'AVG_SALARY', COUNT(DEP_ID) 
AS 'NUM_EMPLOYEES' FROM EMPLOYEES GROUP BY DEP_ID
ORDER BY AVG_SALARY;

--- Query10 ---
SELECT DEP_ID, AVG(SALARY) AS 'AVG_SALARY', COUNT(DEP_ID)
AS 'NUM_EMPLOYEES' FROM EMPLOYEES GROUP BY DEP_ID
HAVING COUNT(DEP_ID) < 4;

--- Query11 ---
SELECT F_NAME, L_NAME, DEP_ID from EMPLOYEES
ORDER BY DEP_ID DESC, L_NAME DESC;

--- Query12 ---
SELECT EMP_ID, SALARY, (SELECT AVG(SALARY) FROM EMPLOYEES)
AS AVG_SALARY FROM EMPLOYEES;

--- Query13 ---
SELECT * FROM(SELECT EMP_ID, F_NAME, L_NAME, DEP_ID 
        FROM EMPLOYEES) AS EMP4ALL;

--- Query14 ---
SELECT * FROM EMPLOYEES WHERE DEP_ID IN (SELECT DEPT_ID_DEP 
FROM DEPARTMENTS);

--- Query15 ---
select * from employees where DEP_ID IN 
   ( select DEPT_ID_DEP from departments where LOC_ID = 'L0002');
   
 --- Query16 ---
 select DEPT_ID_DEP, DEP_NAME from departments 
 where DEPT_ID_DEP IN ( select DEP_ID from employees 
 where SALARY > 70000 );  
 
--- Query17 ---
select D.DEP_NAME , E.F_NAME, E.L_NAME
from EMPLOYEES as E, DEPARTMENTS as D
where E.DEP_ID = D.DEPT_ID_DEP;

--- Query18 ---
select E.F_NAME,E.L_NAME, JH.START_DATE 
	from EMPLOYEES as E 
	INNER JOIN JOB_HISTORY as JH on E.EMP_ID=JH.EMPL_ID 
	where E.DEP_ID ='5';
	
--- Query19 ---	
select E.F_NAME,E.L_NAME, JH.START_DATE, J.JOB_TITLE 
	from EMPLOYEES as E 
	INNER JOIN JOB_HISTORY as JH on E.EMP_ID=JH.EMPL_ID 
	INNER JOIN JOBS as J on E.JOB_ID=J.JOB_IDENT
	where E.DEP_ID ='5';

--- Query 20 ---
select E.EMP_ID,E.L_NAME,E.DEP_ID,D.DEP_NAME
	from EMPLOYEES AS E 
	LEFT OUTER JOIN DEPARTMENTS AS D ON E.DEP_ID=D.DEPT_ID_DEP;
	
--- Query 21 ---
select E.EMP_ID,E.L_NAME,E.DEP_ID,D.DEP_NAME
	from EMPLOYEES AS E 
	LEFT OUTER JOIN DEPARTMENTS AS D ON E.DEP_ID=D.DEPT_ID_DEP 
	where YEAR(E.B_DATE) < 1980;

--- alt Query 22 ---
select E.EMP_ID,E.L_NAME,E.DEP_ID,D.DEP_NAME
	from EMPLOYEES AS E 
	INNER JOIN DEPARTMENTS AS D ON E.DEP_ID=D.DEPT_ID_DEP 
	where YEAR(E.B_DATE) < 1980;

--- Query 23 ---
select E.EMP_ID,E.L_NAME,E.DEP_ID,D.DEP_NAME
	from EMPLOYEES AS E 
	LEFT OUTER JOIN DEPARTMENTS AS D ON E.DEP_ID=D.DEPT_ID_DEP 
	AND YEAR(E.B_DATE) < 1980;

--- Query 24 ---
select E.F_NAME,E.L_NAME,D.DEP_NAME
	from EMPLOYEES AS E 
	FULL OUTER JOIN DEPARTMENTS AS D ON E.DEP_ID=D.DEPT_ID_DEP;

--- Query 25 ---
select E.F_NAME,E.L_NAME,D.DEPT_ID_DEP, D.DEP_NAME
	from EMPLOYEES AS E 
	FULL OUTER JOIN DEPARTMENTS AS D ON E.DEP_ID=D.DEPT_ID_DEP AND E.SEX = 'M';

--- alt Query 26 ---
select E.F_NAME,E.L_NAME,D.DEPT_ID_DEP, D.DEP_NAME
	from EMPLOYEES AS E 
	LEFT OUTER JOIN DEPARTMENTS AS D ON E.DEP_ID=D.DEPT_ID_DEP AND E.SEX = 'M';
