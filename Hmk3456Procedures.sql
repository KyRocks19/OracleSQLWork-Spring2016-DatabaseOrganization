/*4. When the user inputs a student’s name, he should view all the details that are marked public.
This procedure only takes into account a single account_visible variable in a given person's profile. 
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
/*5. When the user inputs a forum name, display the three most popular topics i.e the topics with most
comments (in descending order).*/
CREATE OR REPLACE 
PROCEDURE Get_Popular_Topics (
  DF_NAME IN VARCHAR2
) AS   
  t1 Topic%rowtype;
  t2 Topic%rowtype;
  t3 Topic%rowtype;
BEGIN

SELECT W.pt_id
INTO t1.t_id
FROM (SELECT S.pt_id, S.NumberofPosts, ROW_NUMBER() OVER (ORDER BY S.NumberofPosts DESC) R
      FROM (SELECT pt_id, COUNT(pt_id) AS NumberofPosts
            FROM POST
            WHERE pt_id IN (SELECT t_id
                            FROM Topic
                            WHERE Topic.tdf_id IN (SELECT DiscussionForum.df_id
                                                    FROM DiscussionForum
                                                    WHERE 'Friendship Reports' = DiscussionForum.forum_name))
            GROUP BY pt_id) S) W
WHERE R = 1;
 
SELECT W.pt_id
INTO t2.t_id
FROM (SELECT S.pt_id, S.NumberofPosts, ROW_NUMBER() OVER (ORDER BY S.NumberofPosts DESC) R
      FROM (SELECT pt_id, COUNT(pt_id) AS NumberofPosts
            FROM POST
            WHERE pt_id IN (SELECT t_id
                            FROM Topic
                            WHERE Topic.tdf_id IN (SELECT DiscussionForum.df_id
                                                    FROM DiscussionForum
                                                    WHERE 'Friendship Reports' = DiscussionForum.forum_name))
            GROUP BY pt_id) S) W
WHERE R = 2;
 
 

SELECT W.pt_id
INTO t3.t_id
FROM (SELECT S.pt_id, S.NumberofPosts, ROW_NUMBER() OVER (ORDER BY S.NumberofPosts DESC) R
      FROM (SELECT pt_id, COUNT(pt_id) AS NumberofPosts
            FROM POST
            WHERE pt_id IN (SELECT t_id
                            FROM Topic
                            WHERE Topic.tdf_id IN (SELECT DiscussionForum.df_id
                                                    FROM DiscussionForum
                                                    WHERE 'Friendship Reports' = DiscussionForum.forum_name))
            GROUP BY pt_id) S) W
WHERE R = 3;

SELECT *
INTO t1
FROM Topic
WHERE t1.t_id = topic.t_id;

SELECT *
INTO t2
FROM Topic
WHERE t2.t_id = topic.t_id;

SELECT *
INTO t3
FROM Topic
WHERE t3.t_id = topic.t_id;


  DBMS_OUTPUT.PUT_LINE('First topic: ' || t1.t_name);
  DBMS_OUTPUT.PUT_LINE('Second topic: ' || t2.t_name);
  DBMS_OUTPUT.PUT_LINE('Third Topic: ' || t3.t_name);

END Get_Popular_Topics;
/


/*6. Update student GPA whenever a professor modifies course grade*/
CREATE OR REPLACE TRIGGER UpdateGPA
AFTER UPDATE OF grade ON COURSEGRADE
  REFERENCING NEW AS NewRow
FOR EACH ROW
WHEN (1=1)
DECLARE
  tr_gpa NUMBER;
  tr_s_id NUMBER;
BEGIN
  SELECT s.student_id, (((:NEWROW.grade * :NEWROW.c_credits) / :NEWROW.c_credits) + :NEWROW.bonus_credit + s.GPA) AS GPA
  INTO tr_s_id, tr_gpa
  FROM Student s
  WHERE s.student_id = :NEWROW.S_ID;
  
  UPDATE Student
  SET GPA = tr_gpa
  WHERE student_id = tr_s_id;
  
  DBMS_OUTPUT.PUT_LINE('New GPA: ' || tr_gpa);
  
END;
/

SET SERVEROUTPUT ON
/*This is needed in order to use DBMS_OUTPUT stuff, it's for debugging (Evaluate this line by itself)*/

DECLARE
  row Person%rowtype;  
  discname VARCHAR2(20);
  
BEGIN
  
  row.f_name := 'Rick';
  row.l_name := 'Man';
  
  Get_Public_Attributes(row.f_name, row.l_name, row.email);
  
  discname := 'Friendship Reports';
  
  Get_Popular_Topics(discname);
  
  UPDATE COURSEGRADE
  SET grade = 90
  WHERE s_id = 103 AND c_id = 312;
  
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