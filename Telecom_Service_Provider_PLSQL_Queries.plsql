 """/* 1. Write a Stored Procedure in PLSQL to update the “salary” table by increasing the salary of the employee whose ID is ‘10’ by 2000. */"""
CREATE OR REPLACE PROCEDURE updatesalary(Id INT)
IS
BEGIN
    UPDATE Salary
    SET Salary = Salary + 2000
    WHERE Employee_Id = Id;
    COMMIT;
END;
/

"""/* 2. Write a user defined function to count the total records inserted into the ‘employee’ table and return the resulting value. Execute the function and check the returned value. */"""
CREATE OR REPLACE FUNCTION totalemp
RETURN INT
IS
    c INT;
BEGIN
    SELECT COUNT(*) INTO c FROM employee;
    RETURN c;
END;
/

"""/* 3. Write a Stored Procedure in PLSQL to insert a new record to the ‘department’ table. */"""
CREATE OR REPLACE PROCEDURE DEPARTMENT_INSERT(
    d_id IN department.DepartmentId%TYPE,
    d_name IN department.DepartmentName%TYPE
)
IS
BEGIN
    INSERT INTO department(DepartmentId, DepartmentName)
    VALUES (d_id, d_name);
    COMMIT;
END;
/

"""/* 4. Write a User defined function to count the number of employees whose salary exceeds 40000 and return the resulting value. Execute the function and check the return value. */"""
CREATE OR REPLACE FUNCTION emplist
RETURN INT
IS
    e_c INT;
BEGIN
    SELECT COUNT(*) INTO e_c FROM salary
    WHERE Salary > 40000;
    RETURN e_c;
END;
/

"""/* 5. Write a Stored Procedure in PLSQL to insert a new record to the ‘employee’ table and also show the count of a record before and after inserting it into the table. */"""
CREATE OR REPLACE PROCEDURE employee_INSERT(
    E_Id IN employee.Employee_ID%TYPE,
    E_Name IN employee.Employee_Name%TYPE,
    Age IN employee.Age%TYPE,
    Ssn IN employee.Ssn%TYPE,
    S_S_Id1 IN employee.Salary_Salary_Id1%TYPE,
    D_D_Id IN employee.Department_Department_Id%TYPE
)
IS
BEGIN
    INSERT INTO employee(Employee_ID, Employee_Name, Age, Ssn, Salary_Salary_Id1, Department_Department_Id)
    VALUES(E_Id, E_Name, Age, Ssn, S_S_Id1, D_D_Id);
    COMMIT;
END;
/

"""/* 6. Write a trigger in PLSQL that gets triggered before the action is completed and the triggered action is as follows Covert the Employee_name to upper case before the mentioned record is inserted in the ‘employee’ table and display the converted Employee_name and then the output console should display trigger fired. NOTE: TRIGGER NAME EMPLOYEE_NAME */"""
CREATE TRIGGER EMPLOYEE_NAME BEFORE INSERT ON employee
FOR EACH ROW
BEGIN
    :NEW.EMPLOYEE_NAME := UPPER(:NEW.EMPLOYEE_NAME);
    DBMS_OUTPUT.PUT_LINE('Trigger fired');
END;
/

"""/* 7. Write a trigger in PLSQL that gets triggered before the action is completed and the triggered action is as follows Covert the Employee_name to lower case before the mentioned record is inserted in the ‘employee’ table and display the converted Employee_name and then the output console should display trigger fired. NOTE: TRIGGER NAME EMPLOYEE_NAME */"""
CREATE TRIGGER EMPLOYEE_NAME BEFORE INSERT ON employee
FOR EACH ROW
BEGIN
    :NEW.EMPLOYEE_NAME := LOWER(:NEW.EMPLOYEE_NAME);
    DBMS_OUTPUT.PUT_LINE('Trigger fired');
END;
/

"""/* 8. Write a trigger in PLSQL that gets triggered when we update the record in the ‘employee’ table. When the Employee_ID ‘1’ name is updated as ‘Vikram’, the console should throw ‘Updated successfully’ message after the update and list all the records from ‘employee’. NOTE: TRIGGER NAME :EMP */"""
CREATE TRIGGER EMP AFTER UPDATE ON employee
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('Updated successfully');
END;
/

"""/* 9. Write a trigger in PLSQL that checks if ‘Salary’ is greater than 15000 for any new row that is inserted to the table ‘salary’, then insert a row to the new table SALARY1. NOTE: SALARY1 table is already created in the initial query TRIGGER NAME: SAL */"""
CREATE TRIGGER SAL AFTER INSERT ON salary
FOR EACH ROW
BEGIN
    IF :NEW.Salary > 15000 THEN
        INSERT INTO SALARY1(SalaryId, Employee_name, DepartmentID, Salary, Employee_Id)
        VALUES(:NEW.SalaryId, :NEW.Employee_name, :NEW.DepartmentID, :NEW.Salary, :NEW.Employee_ID);
    END IF;
END;
/

"""/* 10. Write a trigger in PLSQL that gets triggered when inserting the record in the ‘employee’ table and the output console should display ‘inserted successfully’ after insertion. NOTE: TRIGGER NAME: EMP */"""
CREATE TRIGGER EMP AFTER INSERT ON employee
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('Inserted successfully');
END;
/

"""/* 11. Write a cursor in PLSQL to display the department list from the ‘department’ table */"""
DECLARE
    CURSOR department_cursor IS
        SELECT DepartmentName FROM Department;
    v_dep Department.DepartmentName%TYPE;
BEGIN
    OPEN department_cursor;
    LOOP
        FETCH department_cursor INTO v_dep;
        EXIT WHEN department_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_dep);
    END LOOP;
    CLOSE department_cursor;
END;
/

"""/* 12. Write a cursor in PLSQL to display the Employee_Name and department name. */"""
DECLARE
    CURSOR emp_dept_cursor IS
        SELECT e.Employee_Name, d.DepartmentName
        FROM employee e
        JOIN department d ON e.Department_Department_Id = d.departmentId;
    v_en employee.Employee_Name%TYPE;
    v_dep department.DepartmentName%TYPE;
BEGIN
    OPEN emp_dept_cursor;
    LOOP
        FETCH emp_dept_cursor INTO v_en, v_dep;
        EXIT WHEN emp_dept_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_en || ' ' || v_dep);
    END LOOP;
    CLOSE emp_dept_cursor;
END;
/

"""/* 13. Write a cursor in PLSQL to display the Employee_Name from ‘employee’ table and salary details. */"""
DECLARE
    CURSOR emp_salary_cursor IS
        SELECT e.Employee_Name, s.Salary
        FROM employee e
        JOIN salary s ON e.Salary_Salary_Id1 = s.SalaryId;
    v_en employee.Employee_Name%TYPE;
    v_sal salary.Salary%TYPE;
BEGIN
    OPEN emp_salary_cursor;
    LOOP
        FETCH emp_salary_cursor INTO v_en, v_sal;
        EXIT WHEN emp_salary_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_en || ' ' || v_sal);
    END LOOP;
    CLOSE emp_salary_cursor;
END;
/

"""/* 14. Write a cursor in PLSQL to display the Employee_Name list who are all getting salaries greater than or equal to 50000 from the department ‘CustomerCare’. */"""
DECLARE
    CURSOR employee_cursor IS
        SELECT e.Employee_Name
        FROM employee e
        JOIN salary s ON e.Salary_Salary_Id1 = s.SalaryId
        JOIN department d ON e.Department_Department_Id = d.DepartmentId
        WHERE d.DepartmentName = 'CustomerCare' AND s.Salary >= 50000;
    v_emp_n employee.Employee_Name%TYPE;
BEGIN
    OPEN employee_cursor;
    LOOP
        FETCH employee_cursor INTO v_emp_n;
        EXIT WHEN employee_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_emp_n);
    END LOOP;
    CLOSE employee_cursor;
END;
/

"""/* 15. Write a cursor in PLSQL to display the Employee_Name whose LocationName is equals to “Boston”. */"""
DECLARE
    CURSOR employee_cursor IS
        SELECT e.Employee_Name
        FROM employee e
        JOIN employeeworklocation ewl ON e.Employee_ID = ewl.Employee_Employee_Id
        JOIN worklocation w ON ewl.Work_Location_Location_Id = w.Location_Id
        WHERE w.LocationName = 'Boston';
    v_emp_n employee.Employee_Name%TYPE;
BEGIN
    OPEN employee_cursor;
    LOOP
        FETCH employee_cursor INTO v_emp_n;
        EXIT WHEN employee_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_emp_n);
    END LOOP;
    CLOSE employee_cursor;
END;
/

