/*6. Update student GPA whenever a professor modifies course grade*/
CREATE OR REPLACE TRIGGER UpdateGPA
AFTER UPDATE OF grade ON COURSEGRADE
  REFERENCING NEW AS NewRow OLD AS OLDROW
FOR EACH ROW
WHEN (1=1)
DECLARE
  tr_gpa NUMBER;
  tr_s_id NUMBER;
BEGIN
  SELECT s.student_id, (((:NEWROW.grade / :NEWROW.c_credits) + :NEWROW.bonus_credit) - ((:OLDROW.grade / :OLDROW.c_credits) + :OLDROW.bonus_credit) + s.GPA) AS GPA
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

BEGIN

  UPDATE STUDENT
  SET GPA = 10
  WHERE student_id = 103;
  /*This call represents a professor updating the course grade of student 103 in course 312*/
  UPDATE COURSEGRADE
  SET grade = 50
  WHERE s_id = 103 AND c_id = 312;

END;
/
