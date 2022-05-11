Aggregating, Grouping
---------------------

-- Study the following query and its result.
-- You can see the behaviour of aggregating functions. 
SELECT count(comm), count(*), count(sal), count(distinct sal), 
       sum(sal), sum(distinct sal), trunc(avg(sal)), avg(distinct sal)
FROM nikovits.emp WHERE ename like '%O%';


Queries for the following tables (see description of the columns in previous exrcises)
--------------------------------
NIKOVITS.EMP (empno, ename, job, mgr, hiredate, sal, comm, deptno)
NIKOVITS.DEPT(deptno, dname, loc)
NIKOVITS.SAL_CAT(category, lowest_sal, highest_sal)
---------------------------------------------------


1.  Give the maximal salary.
SELECT max(sal) FROM emp;

2.  Give the sum of all salaries.
SELECT sum(sal) FROM emp;

3.  Give the summarized salary and average salary on department 20.
SELECT sum(sal), avg(sal) FROM emp WHERE deptno=20;

4.  How many different jobs we have in emp table?
SELECT count(DISTINCT job) FROM emp;

5.  Give the number of employees whose salary is greater than 2000.
SELECT count(*) FROM emp WHERE sal > 2000;

6.  Give the average salary by departments. (deptno, avg_sal)
SELECT deptno, round(avg(sal)) FROM emp GROUP BY deptno;

7.  Give the location and average salary by departments. (deptno, loc, avg_sal)
SELECT d.deptno, loc, round(avg(sal)) 
FROM emp e, dept d
WHERE d.deptno=e.deptno 
GROUP BY d.deptno, loc;
-- with a different syntax (NATURAL JOIN):
SELECT deptno, loc, round(avg(sal)) 
FROM emp NATURAL JOIN dept 
GROUP BY deptno, loc;

8.  Give the number of employees by departments. (deptno, num_emp)
SELECT deptno, count(empno) FROM emp GROUP BY deptno;

9.  Give the average salary by departments where this average is greater than 2000. (deptno, avg_sal)
SELECT deptno, avg(sal) FROM emp GROUP BY deptno HAVING avg(sal) > 2000;

10.  Give the average salary by departments where the department has at least 4 employees. (deptno, avg_sal)
SELECT deptno, avg(sal) FROM emp GROUP BY deptno HAVING count(empno) >= 4;

11.  Give the average salary and location by departments where the department has at least 4 employees.
SELECT d.deptno, loc, avg(sal) FROM emp e, dept d
WHERE d.deptno=e.deptno 
GROUP BY d.deptno, loc HAVING count(empno) >= 4;

12. Give the name and location of departments where the average salary is greater than 2000. (dname, loc)
SELECT dname, loc FROM emp d, dept o
WHERE d.deptno=o.deptno 
GROUP BY dname, loc HAVING avg(sal) >= 2000;

13. Give the salary categories where we can find exactly 3 employees.
SELECT category FROM emp, sal_cat
WHERE sal BETWEEN lowest_sal AND highest_sal
GROUP BY category HAVING count(*) = 3;
-- other syntax (JOIN ON):
SELECT category FROM emp JOIN sal_cat ON (sal BETWEEN lowest_sal AND highest_sal)
GROUP BY category HAVING count(*) = 3;

14.  Give the salary categories where the employees in this category work on the same department.
SELECT category FROM emp, sal_cat
WHERE sal BETWEEN lowest_sal AND highest_sal
GROUP BY category HAVING count(distinct deptno) = 1;

15. List the number of employees whose empno is an even number and list the number whose empno is odd. (parity, num_of_emps)
SELECT decode(mod(empno, 2), 0, 'even', 1, 'odd') parity, count(empno) num_of_emps 
FROM emp GROUP BY mod(empno, 2);

16. List the number of employees and average salary by jobs. Print the average salary with a character string 
    containing '#'-s where one '#' denotes 200. So if the average is 600 print '###'.
SELECT job, count(empno), round(avg(sal)),
      rpad('#', round(avg(sal)/200), '#') 
FROM emp GROUP BY job;

