Employees stored in a table

EMP (empno, ename, job, mgr, hiredate, sal, comm, deptno)	   
----------------------------------------------------------
7369	SMITH	CLERK     7902	1980-12-17   800        20
7499	ALLEN	SALESMAN  7698	1981-02-20  1600   300  30
7521	WARD	SALESMAN  7698	1981-02-22  1250   500  30
7566	JONES	MANAGER   7839	1981-04-02  2975        20
7654	MARTIN	SALESMAN  7698	1981-09-28  1250  1400  30
7698	BLAKE	MANAGER   7839	1981-05-01  4250        30
7782	CLARK	MANAGER   7839	1981-06-09  2450   200  10
7788	SCOTT	ANALYST   7566	1982-12-09  3000        20
7839	KING	PRESIDENT       1981-11-17  5000        10
7844	TURNER	SALESMAN  7698	1981-09-08  1500    10  30
7876	ADAMS	CLERK     7788	1983-01-12  1100        20
7900	JAMES	CLERK     7698	1981-12-03   950        30
7902	FORD	ANALYST   7566	1981-12-03  3000   700  20
7934	MILLER	CLERK     7782	1982-01-23  1300   600  10

-- DROP table emp;   

CREATE TABLE "EMP"                     -- creates an empty table
   (	"EMPNO" NUMBER(4,0),           -- employee number, unique identifier of an employee
	"ENAME" VARCHAR2(30 BYTE),     -- employee name
	"JOB" VARCHAR2(27 BYTE),       -- job
	"MGR" NUMBER(4,0),             -- manager's employee number
	"HIREDATE" DATE,               -- start date, when emloyee entered  
	"SAL" NUMBER(7,2),             -- salary
	"COMM" NUMBER(7,2),            -- commission
	"DEPTNO" NUMBER(2,0)           -- department number of employee's department
   );                                

GRANT SELECT ON emp TO public;   -- grants read (select) privilege to all users
SELECT * FROM nikovits.emp;      -- not empty table

INSERT INTO emp                  -- We can insert records into the TABLE (we'll see it later)
VALUES (7369, 'SMITH', 'CLERK', 7902, TO_Date('1980.12.17', 'YYYY.MM.DD'), 800, NULL, 20); 

Give the following queries in SQL: (based on table nikovits.emp)
---------------------------------------------------------
1.  List the employees whose salary is greater than 2800.
2.  List the employees working on department 10 or 20.
3.  List the employees whose commission is greater than 600.
4.  List the employees whose commission is NOT greater than 600.
5.  List the employees whose commission is not known (that is NULL).
SELECT ename, comm FROM emp WHERE comm IS NULL;

6.  List the jobs of the employees (with/without duplication).
-- with/without DISTINCT
SELECT DISTINCT job FROM emp;

7.  Give the name and double salary of employees working on department 10.
8.  List the employees whose hiredate is greater than 1982.01.01.
-- see date format and conversion function
SELECT ename, hiredate FROM emp where hiredate > to_date('1982.01.01', 'yyyy.mm.dd');

9.  List the employees who doesn't have a manager.
SELECT ename FROM emp WHERE mgr IS NULL;

10. List the employees whose name contains a letter 'A'.
SELECT ename FROM emp WHERE ename LIKE '%A%';

11. List the employees whose name contains two letters 'L'.
SELECT ename FROM emp WHERE ename LIKE '%L%L%';

12. List the employees whose salary is between 2000 and 3000.
SELECT ename, sal FROM emp WHERE sal BETWEEN 2000 AND 3000;

13. List the name and salary of employees ordered by salary.
14. List the name and salary of employees ordered by salary in descending order and 
    within that order, ordered by name in ascending order.
SELECT ename, sal FROM emp ORDER BY sal DESC, ename ASC;

15. List the employees whose manager is KING. (reading empno of KING from monitor)
16. List the employees whose manager is KING. (without reading from monitor)
SELECT e2.ename FROM emp e1, emp e2 WHERE e1.empno = e2.mgr AND e1.ename='KING';


==========================================================
A new table: information about preferences. Who likes what.
LIKES (name, fruits)
----------------------

NAME     FRUITS
---------------
Piglet   apple
Piglet   pear
Piglet   raspberry
Winnie   apple
Winnie   pear
Kanga    apple
Tiger    apple
Tiger    pear

-- DROP TABLE likes; (drop the table if it exists already)

-- Create your own empty table.
CREATE TABLE LIKES (NAME varchar(14), FRUITS varchar(14));

-- Insert rows into the table.

   insert into LIKES values ('Piglet','apple');
   insert into LIKES values ('Piglet','pear');
   insert into LIKES values ('Piglet','raspberry');
   insert into LIKES values ('Winnie','apple');
   insert into LIKES values ('Winnie','pear');
   insert into LIKES values ('Kanga','apple');
   insert into LIKES values ('Tiger','apple');
   insert into LIKES values ('Tiger','pear');

commit;  -- see later, but don't forget, it is important
-- grant select on LIKES to public;

SELECT * FROM likes;  -- query your own table

-- Query the table of the instructor: 
SELECT * FROM nikovits.likes;

-- Create your own table from an existing one: (don't forget to drop the old one if exists)
CREATE TABLE likes AS SELECT * FROM nikovits.likes;

Give the following queries in Relational Algebra and SQL: (based on table nikovits.likes)
---------------------------------------------------------
1. List the fruits that Winnie likes.
SELECT fruits FROM likes WHERE name = 'Winnie';

2. List the fruits that Winnie doesn't like but someone else does.
-- subtract Winnie's fruits from all fruits
SELECT fruits FROM likes
 MINUS
SELECT fruits FROM likes WHERE name = 'Winnie';

3. Who likes apple?
SELECT name FROM likes WHERE fruits = 'apple';

4. List those names who doesn't like pear but like something else.
SELECT name FROM likes
 MINUS
SELECT name FROM likes WHERE fruits = 'pear';

5. Who likes raspberry or pear? 
SELECT name FROM likes WHERE fruits = 'raspberry'
 UNION
SELECT name FROM likes WHERE fruits = 'pear';

6. Who likes both apple and pear?
SELECT name FROM likes WHERE fruits = 'apple'
 INTERSECT
SELECT name FROM likes WHERE fruits = 'pear';

7. Who likes apple but doesn't like pear? 
SELECT name FROM likes WHERE fruits = 'apple'
 MINUS
SELECT name FROM likes WHERE fruits = 'pear';
