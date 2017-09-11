/*4. When the user inputs a student’s name, he should view all the details that are marked public.

This procedure only takes into account a single account_visible variable that currently resides in a given person's Person table. 
In the actual database, each individual attribute on each person's profile would need its own _visible variable, and 
Get_Public_Attributes would have to loop through the entire profile, find the variables marked with _Visible, see if they are set to 'True', 
and then save / output the variable that they correspond to if they are true.*/
CREATE OR REPLACE 
PROCEDURE Get_Public_Attributes (
  PF_NAME IN OUT VARCHAR2,
  PL_NAME IN OUT VARCHAR2,
  PEMAIL OUT VARCHAR2
) AS   
  status VARCHAR2(5);
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

SET SERVEROUTPUT ON
/*This is needed in order to use DBMS_OUTPUT stuff, it's for debugging (Evaluate this line by itself)*/

/*This is a test block to check to make sure the above procdure functions as expected*/
DECLARE
  row Person%rowtype;  
BEGIN
  row.f_name := 'Rick';
  row.l_name := 'Man';
  
  Get_Public_Attributes(row.f_name, row.l_name, row.email);

  DBMS_OUTPUT.PUT_LINE('First name: ' || row.f_name);
  DBMS_OUTPUT.PUT_LINE('Last name: ' || row.l_name);
  DBMS_OUTPUT.PUT_LINE('Email: ' || row.email);
  
  row.f_name := 'Morty';
  row.l_name := 'Man';
  
  
  Get_Public_Attributes(row.f_name, row.l_name, row.email);
  
  
  DBMS_OUTPUT.PUT_LINE('First name: ' || row.f_name);
  DBMS_OUTPUT.PUT_LINE('Last name: ' || row.l_name);
  DBMS_OUTPUT.PUT_LINE('Email: ' || row.email);
/* These lines will print out the data that the procedure returned into the variables in row. */
END;
/
