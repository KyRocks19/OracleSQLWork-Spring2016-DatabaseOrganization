/*5. When the user inputs a forum name, display the three most popular topics i.e the topics with most
comments (in descending order).

The following procedure is fairly large, and could be shortened by using a cursor, maybe. 
However, due to having a ton of other work to do and needing to finish this by the deadline, we have left it as-is. Apologies!
*/
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
                                                    WHERE DF_NAME = DiscussionForum.forum_name))
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
                                                    WHERE DF_NAME = DiscussionForum.forum_name))
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
                                                    WHERE DF_NAME = DiscussionForum.forum_name))
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

SET SERVEROUTPUT ON
/*This is needed in order to use DBMS_OUTPUT stuff, it's for debugging (Evaluate this line by itself)*/

/*This is a test block to check to make sure the above procdure functions as expected*/
DECLARE
  discname VARCHAR2(20);
BEGIN
  discname := 'Friendship Reports';
  Get_Popular_Topics(discname);
END;
/
