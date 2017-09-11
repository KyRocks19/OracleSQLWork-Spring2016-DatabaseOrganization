--7. update student's point when he/she posts a comment in the forum--

Create Or Replace Trigger T_Post
after insert ON Post
FOR EACH ROW

declare addPoint number;
pid number;
--find the person_id who added a post/comment, not sure post is different from comment??
-- pid  := (select new.author_id


Begin
pid := :new.author_id;
--add point exchange logic if any
addPoint := 1;

--update points in GroupMemberAccount table for that id
update GroupMemberAccount
set points = points+addPoint
where gmap_id = pid;
DBMS_OUTPUT.PUT_LINE('New POINTS: ' || ADDPOINT);
End;
/
/*TEST CODE*/
DECLARE

BEGIN

  /*This call represents a post being added to a discussion forum topic*/

  INSERT INTO POST
  VALUES(109998, 103, 'A really insightful comment', '01-20-18', 102, 'N');
  
END;

