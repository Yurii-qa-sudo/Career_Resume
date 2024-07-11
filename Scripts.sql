/* SELECT * FROM employees; */
/* SELECT  employee_no, title from titles;*/
/* SELECT DISTINCT city FROM employeeTerritories;*/ 
/* SELECT employee_no, last_name FROM employees
ORDER BY last_name;*/
SELECT first_name, last_name FROM employees
WHERE employee_no = 10070;
SELECT last_name, birth_date
FROM employees
WHERE birth_date BETWEEN '1960-01-01' AND '1964-12-31' 
ORDER BY last_name ASC ;
SELECT employee_no, title FROM titles WHERE title LIKE "S_n_or%";
SELECT employee_no, city FROM employeeTerritories WHERE city LIKE 'K___%';

SELECT COUNT(gender) AS Female FROM employees
WHERE gender = 'F';

SELECT employee_no, first_name, last_name, hire_date  FROM employees
ORDER BY hire_date DESC ;
SELECT first_name, last_name, birth_date FROM employees 
WHERE birth_date >= '1960-01-01';
SELECT first_name, last_name, birth_date FROM employees WHERE first_name LIKE "Ma%";

SELECT COUNT(title) AS 'total engineers' FROM titles
WHERE title = 'Engineer';

SELECT city, COUNT(city) FROM employeeTerritories
GROUP BY city HAVING COUNT(city)>=10;

SELECT first_name, last_name, title FROM employees  JOIN ( SELECT * max (from_date) AS max_d  FROM titles t) ON  from_date=t.max_d;

SELECT e.first_name, e.last_name, t.title
FROM employees e
JOIN (
    SELECT t1.employee_no, t1.title
    FROM titles t1
    JOIN (
        SELECT employee_no, MAX(from_date) AS max_from_date
        FROM titles
        GROUP BY employee_no
    ) t2 ON t1.employee_no = t2.employee_no AND t1.from_date = t2.max_from_date
) t ON e.employee_no = t.employee_no;

SELECT e.first_name, e.last_name, t.salary
FROM employees e
JOIN 
   (SELECT t1.employee_no, t1.salary FROM salaries t1 
   JOIN 
      ( SELECT employee_no, MAX(salary) AS max_salary FROM salaries 
      WHERE salary BETWEEN 50000 AND 60000 GROUP BY employee_no)
   t2 ON t1.employee_no = t2.employee_no AND t1.salary = t2.max_salary)
 t ON e.employee_no = t.employee_no;
