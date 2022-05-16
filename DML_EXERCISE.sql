Exercises for DELETE, INSERT, UPDATE
------------------------------------

NIKOVITS.EMP (empno, ename, job, mgr, hiredate, sal, comm, deptno)
NIKOVITS.DEPT(deptno, dname, loc)
NIKOVITS.SAL_CAT(category, lowest_sal, highest_sal)

/* You should create a copy from the tables before modifying the data

CREATE TABLE emp2 AS SELECT * FROM nikovits.emp;
CREATE TABLE dept2 AS SELECT * FROM nikovits.dept;
UPDATE emp2 ...
Check the data after modification: SELECT * FROM emp2; SELECT * FROM dept2;         
Drop the modified tables: DROP TABLE emp2; DROP TABLE emp2;

*/

DELETE
------
1. Delete the employees whose commission is null.
DELETE FROM emp WHERE comm IS NULL;

2. Delete the employees whose hiredate was before 1982.01.01.
DELETE FROM emp WHERE hiredate < TO_DATE('1982.01.01', 'yyyy.mm.dd');

3. Delete the employees whose department's location is DALLAS.
DELETE FROM emp WHERE deptno IN 
   (SELECT deptno FROM dept WHERE loc = 'DALLAS');

4. Delete the employees whose salary is less than the average salary.
DELETE FROM emp WHERE sal < (SELECT AVG(sal) FROM emp);

5. Delete the employees whose salary is less than the average salary on his department.
DELETE FROM emp e1 WHERE sal < (SELECT AVG(sal) FROM emp WHERE deptno=e1.deptno);

6. Delete the employee (employees) whose salary is the greatest.
DELETE FROM emp WHERE sal = (SELECT MAX(sal) FROM emp);

7. Delete the departments which have an employee with salary category 2.
DELETE FROM dept WHERE EXISTS
  (SELECT * FROM emp, sal_cat 
   WHERE sal BETWEEN lowest_sal AND highest_sal AND CATEGORY=2
   AND emp.deptno=dept.deptno);

8. Delete the departments which have at least two employees with salary category 2.
DELETE FROM dept WHERE deptno IN
  (SELECT deptno FROM emp, sal_cat 
   WHERE sal BETWEEN lowest_sal AND highest_sal AND CATEGORY=2
   GROUP BY deptno
   HAVING count(distinct empno) >= 2);

INSERT
------
9. Insert a new employee with the following values:
   empno=1, ename='Smith', deptno=10, hiredate=sysdate, salary=average salary in department 10.
   All the other columns should be NULL.
a) Insert the row with the 'VALUES' keyword
b) Insert the row with a SELECT query without 'VALUES' keyword.

a)
INSERT INTO emp(empno, ename, hiredate, sal, deptno) 
VALUES(1,'Smith', SYSDATE, (SELECT AVG(sal) FROM emp WHERE deptno=10),10);

b)
INSERT INTO emp(empno, ename, hiredate, sal, deptno) 
SELECT 1,'Smith', SYSDATE, AVG(sal), 10 FROM emp WHERE deptno=10;

UPDATE
------
10. Increase the salary of the employees in department 20 with 20%.
UPDATE emp SET sal = sal*1.2 WHERE deptno=20;

11. Increase the salary with 500 for the employees whose commission is NULL or whose 
    salary is less than the average.
UPDATE emp SET sal = sal + 500 
WHERE comm IS NULL OR sal < ( SELECT AVG(sal) FROM emp);

12. Increase the commission of all employees with the maximal commission.
    If an employee has NULL commission, treat it as 0.
UPDATE emp SET comm = NVL(comm,0) + (SELECT MAX(emp1.comm) from emp emp1);  -- NVL is important!!!

13. Modify the name of the employee with the lowest salary to 'Poor'.
UPDATE emp SET ename = 'Poor' 
WHERE sal = (SELECT MIN(sal) FROM emp);

14. Increase the commission of the employees with 3000, who has at least 2 direct subordinates.
    If an employee has NULL commission, treat it as 0.
UPDATE emp SET comm=coalesce(comm,0)+3000 WHERE empno IN
  (SELECT mgr FROM emp GROUP BY mgr HAVING count(*) >= 2);

15. Increase the salary of those employees who has a subordinate. The increment is the minimal salary.
UPDATE emp SET sal = sal + (SELECT min(sal) from emp) 
WHERE empno IN (SELECT mgr FROM emp);

16. Increase the salary of the employees who don't have a subordinate. The increment is
    the average salary of their own department.
UPDATE emp e1 SET sal = sal + (SELECT avg(sal) FROM emp e2 WHERE e2.deptno = e1.deptno)
WHERE empno NOT IN (SELECT coalesce(mgr,0) FROM emp);









  
 
