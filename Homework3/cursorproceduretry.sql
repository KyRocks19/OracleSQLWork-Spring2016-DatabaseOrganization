/*
This is a different approach to problem 4 that ended up not working

4. When the user inputs a student’s name, he should view all the details that are marked public.
This procedure only takes into account a single account_visible variable in a given person's profile. 
In the actual database, each individual attribute on each person's profile would need its own _visible variable, and 
Get_Public_Attributes would have to loop through the entire profile, find the variables marked with _Visible, see if they are set to 'True', 
and then save / output the variable that they correspond to if they are true.*/
CREATE OR REPLACE 
PROCEDURE Get_Public_Attributes (
  PF_NAME IN OUT VARCHAR2,
  PL_NAME IN OUT VARCHAR2,
  PEMAIL OUT VARCHAR2,
  status OUT VARCHAR2
) AS 
BEGIN

  SELECT account_visible
  INTO status
  FROM Person
  WHERE f_name = PF_NAME AND l_name = PL_NAME;
  
  DBMS_OUTPUT.PUT_LINE('STATUS: ' || STATUS);
  
  IF status = 'TRUE' THEN
      SELECT f_name, l_name, email
      INTO PF_NAME, PL_NAME, PEMAIL
      FROM Person
      WHERE f_name = PF_NAME AND l_name = PL_NAME;
  END IF;
END Get_Public_Attributes;
/

SET SERVEROUTPUT ON /*This is needed in order to use DBMS_OUTPUT stuff, it's for debugging (Evaluate this line by itself)*/

DECLARE
  row Person%rowtype;  
  Status VARCHAR2(5);
BEGIN

  row.f_name := 'Rick';
  row.l_name := 'Man';
  Get_Public_Attributes(row.f_name, row.l_name, row.email, Status);
  
  DBMS_OUTPUT.PUT_LINE('First name: ' || row.f_name);
  DBMS_OUTPUT.PUT_LINE('Last name: ' || row.l_name);
  DBMS_OUTPUT.PUT_LINE('Email: ' || row.email);
/* These lines will print out the data that the procedure returned into the variables in row. */
END;
/
/*  
Below is unused junk
PF PERSON.F_NAME%TYPE;
  PL PERSON.L_NAME%TYPE;
  Email Person.email%type;

 ACCEPT pl_name CHAR FORMAT 'A20' PROMPT 'Enter last name:  ',This was an attempt to actually get input from the user.
  ACCEPT pf_name CHAR FORMAT 'A20' PROMPT 'Enter first name: '
CREATE OR REPLACE VIEW view_name AS
  SELECT columns
  FROM table
  WHERE conditions;
  
CREATE OR REPLACE
FUNCTION calculate_score
( cat IN VARCHAR2
, score IN NUMBER
, weight IN NUMBER
) RETURN NUMBER AS
BEGIN
  RETURN NULL;
END calculate_score;


CREATE OR REPLACE
PROCEDURE ADD_EVALUATION
( evaluation_id IN NUMBER
, employee_id IN NUMBER
, evaluation_date IN DATE
, job_id IN VARCHAR2
, manager_id IN NUMBER
, department_id IN NUMBER
) AS
BEGIN
  NULL;
END ADD_EVALUATION;
*/
/*
cursorLoop: LOOP
  DECLARE NotFound CONDITION FOR SQLSTATE '0200';
  Fetch c INTO viewingTable;
    IF 
    IF NotFound THEN LEAVE c ursorLoop;
    END IF;

END LOOP;

*/
