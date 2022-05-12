

We have following two relations: R(A,B,C) and S(C,D). Rewrite the following relational algebra expressions into SQL. Run the SQL queries on the tables R and S and give the results too. Send the SQL and the result.
π A ( γ A; SUM(D) -> SU ( σ A = 'X' ∧C = S.C (R ⨯ S) ) )
τ A ( π A, SU ( σ SU > 10 ∧ SU < 100 ( γ A; SUM(D) -> SU (R ⨝ S) ) ) )
π A (R) - π A ( σ R.B = S.C ∧D < 10 (R ⨯ S) )


We have the following two relations: R(A,B,C) and S(C,D). Rewrite the following SQL queries into (extended) relational algebra. Send the relational algebra expressions. (3x2 points)
SELECT A, SUM(D) FROM R NATURAL JOIN S WHERE D < 10 GROUP BY A;
SELECT A FROM R, S WHERE R.B = S.C GROUP BY A HAVING SUM(D) > 20;
SELECT A, C FROM R CROSS JOIN S WHERE D BETWEEN 2 AND 15 ORDER BY C, A;


The tables on which the SQL queries below are based are the following:

EMP (empno, ename, job, mgr, hiredate, sal, comm, deptno)

DEPT(deptno, dname, loc)

SAL_CAT(category, lowest_sal, highest_sal)

For the following queries send the SQL and the results of the query (or the new table after the modification).



Give the years in which at most two employees started to work (hiredate shows the start of work) and give the number of such employees by year. (Year, Num_emps).


Copy the emp table. Delete the employees from the copied table who have minimal salary within their salary category. (4 points)


Copy the dept table. Insert a new department with the following values:
deptno=60, loc=’LOS ANGELES’.

            All the other columns should be NULL.

Copy the dept table. Rename the department to „NO COMMISSION” where none of the employees have commission. (4 points)


Give the following result for which you can use views, or you can use the WITH statement. Compute the average commission by jobs (job, job_avg), then compute the general average commission (gen_avg), finally give the job name, average commission on that job, the general average and the difference between the job average and the general average. (job, job_avg, gen_avg, diff) If an employee has NULL commission, treat it as 0.
-- 1a
select A, SUM(D) 
from R, S 
where A = 'X' and R.C=S.C 
group by A;

-- 1b
select A, SUM(D) as SU 
from R natural join S 
group by A
having 10<sum(D) and 100>sum(D);

-- 1c
select A from R
minus
select A from R, S where R.B=S.C and D<10;

-- 2a
? A; SUM(D) -> SU (? D < 10 (R ? S))

-- 2b
? A (? SU > 20 (? A; SUM(D) -> SU (? R.B = S.C (R ? S))))

-- 2c
? C, A (? A, R.C (? D >=2 ? D <= 15 (R ? S)))

-- 3
select extract(year from hiredate) as year, count(*) as num_emps
from emp 
group by extract(year from hiredate) 
having count(*)<=2;

-- 4
create table emp_copy as select * from emp;

delete from emp_copy 
where sal in 
(select min(sal) 
from emp, sal_cat
where emp.sal between sal_cat.lowest_sal and sal_cat.highest_sal
group by sal_cat.category);

-- 5
create table dept_copy as select * from dept;

insert into dept_copy(deptno, loc)
values (60, 'LOS ANGELES');

-- 6
create table dept_copy2 as select * from dept;

update dept_copy2
set dname = 'NO COMMISSION'
where not deptno in
(select deptno
from dept_copy2 natural join emp
where not comm is null);

-- 7
create view commbyjobs as
select job, avg(nvl(comm,0)) as job_avg 
from emp
group by job;

create view gencomm as
select avg(nvl(comm,0)) as gen_avg
from emp;

select job, job_avg, gen_avg, (job_avg - gen_avg) diff
from commbyjobs, gencomm;
