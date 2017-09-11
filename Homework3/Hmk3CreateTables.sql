/*Kevin Brewton, Database Organization Spring 2016, Homework 3: Creating the Database Tables*/
CREATE TABLE Account(
username VARCHAR2(255) NOT NULL PRIMARY KEY,
pass VARCHAR2(255) NOT NULL,
p_id NUMBER NOT NULL
);
INSERT INTO GROUPMEMBERACCOUNT VALUES(1000, 1008, 6203, 0, 0, 'KP2016', '204');
CREATE TABLE Person(
person_id NUMBER NOT NULL,
f_name VARCHAR2(255) NOT NULL,
l_name VARCHAR2(255) NOT NULL,
email VARCHAR2(255) NOT NULL,
account_visible VARCHAR2(5),

CONSTRAINT person_is_unique
  UNIQUE (email, f_name, l_name),
CONSTRAINT  person_pk
  PRIMARY KEY (person_id)
);


CREATE TABLE Student(
student_id NUMBER NOT NULL PRIMARY KEY,
f_name VARCHAR2(255) NOT NULL,
l_name VARCHAR2(255) NOT NULL, 
email VARCHAR2(255) NOT NULL,
degree_year NUMBER,
degree_semester VARCHAR2(255),
GPA NUMBER,
degree_status VARCHAR2(255),
degreetype VARCHAR2(255),
course_list VARCHAR2(255),
jobs_internships VARCHAR2(255),

CONSTRAINT student_is_primary_person
  FOREIGN KEY (student_id)
  REFERENCES Person(person_id),
  
CONSTRAINT student_is_unique_person
  FOREIGN KEY (f_name, l_name, email)
  REFERENCES Person(f_name, l_name, email)
);

CREATE TABLE TA(
student_id NUMBER NOT NULL PRIMARY KEY,
course_id NUMBER NOT NULL,
bio CLOB,

CONSTRAINT ta_is_student
  FOREIGN KEY (student_id)
  REFERENCES Student(student_id),

CONSTRAINT ta_teaches_course
  FOREIGN KEY (course_id)
  REFERENCES Course(c_id)
);

CREATE TABLE Faculty(
faculty_id NUMBER NOT NULL PRIMARY KEY, 
f_name VARCHAR2(255) NOT NULL,
l_name VARCHAR2(255) NOT NULL,
email VARCHAR2(255) NOT NULL,
year_joined NUMBER,
research_projects CLOB, /*LOB is a huge block of data, in this case, a summary of research projects completed */
courses_taught CLOB, /*This variable is simply here so that one can easily pull up which classes this instructor teaches. It is just a list of course names */
experience VARCHAR2(255),
school_position VARCHAR2(255),

CONSTRAINT faculty_is_primary_person
  FOREIGN KEY (faculty_id)
  REFERENCES Person(person_id),
  
CONSTRAINT faculty_is_unique_person
  FOREIGN KEY (f_name, l_name, email)
  REFERENCES Person(f_name, l_name, email)
);

CREATE TABLE Course(
c_id NUMBER NOT NULL PRIMARY KEY,
c_name VARCHAR2(255) NOT NULL,
description CLOB,
interest_group NUMBER,
professor NUMBER NOT NULL,
semester VARCHAR2(20),
c_year NUMBER
);

CREATE TABLE GGroup(
g_id NUMBER NOT NULL PRIMARY KEY,
g_name VARCHAR2(255) NOT NULL,
g_type VARCHAR2(255),
information CLOB,
semester VARCHAR2(255),
year_created NUMBER
);

CREATE TABLE CourseInterestGroup(
cig_id  NUMBER NOT NULL PRIMARY KEY,
cig_c_id NUMBER NOT NULL,
professor NUMBER NOT NULL,
past_gpas CLOB
);

CREATE TABLE DiscussionForum(
df_id NUMBER NOT NULL PRIMARY KEY,
dfg_id NUMBER NOT NULL,
time_created DATE,
forum_name VARCHAR2(255)
);

CREATE TABLE Topic(
t_id NUMBER NOT NULL PRIMARY KEY,
tdf_id NUMBER NOT NULL,
t_name VARCHAR2(255),
description CLOB
);

CREATE TABLE Post(
p_id NUMBER NOT NULL PRIMARY KEY,
pt_id NUMBER NOT NULL,
p_comment CLOB,
p_time DATE,
author_id NUMBER NOT NULL,
alert VARCHAR2(1)
);

CREATE TABLE CourseGrade(
cg_id NUMBER NOT NULL PRIMARY KEY,
s_id  NUMBER NOT NULL,
c_id  NUMBER NOT NULL,
grade NUMBER,
bonus_credit  NUMBER
);

CREATE TABLE GroupMemberAccount(
gma_id NUMBER NOT NULL PRIMARY KEY,
gmap_id NUMBER NOT NULL,
gmag_id NUMBER NOT NULL,
points NUMBER,
bonus_points NUMBER, --NOT SURE WHY THIS EXISTS IF WE HAVE POINTS
group_username VARCHAR2(255),
group_password VARCHAR2(255)
);

CREATE TABLE Moderator(
m_id NUMBER NOT NULL PRIMARY KEY,
m_type VARCHAR2(20),
mg_id NUMBER NOT NULL,
m_privileges VARCHAR2(20),
mdf_id NUMBER
);

CREATE TABLE CourseList(
c_id NUMBER NOT NULL,
s_id  NUMBER NOT NULL,
CONSTRAINT pk_courselist PRIMARY KEY(c_id, s_id)
);



ALTER TABLE Course
ADD CONSTRAINT course_has_courseinterestgroup
  FOREIGN KEY (interest_group)
  REFERENCES CourseInterestGroup(cig_id)
ADD CONSTRAINT course_has_professor
  FOREIGN KEY (professor)
  REFERENCES Faculty(faculty_id);

ALTER TABLE CourseInterestGroup
ADD CONSTRAINT cig_has_group
  FOREIGN KEY (cig_id)
  REFERENCES GGroup(g_id)
ADD CONSTRAINT cig_has_professor
  FOREIGN KEY (professor)
  REFERENCES Faculty(faculty_id)
ADD CONSTRAINT cig_has_course
  FOREIGN KEY (cig_c_id)
  REFERENCES Course(c_id);
  
ALTER TABLE DiscussionForum
ADD CONSTRAINT df_has_group
  FOREIGN KEY (dfg_id)
  REFERENCES GGroup(g_id);
  
ALTER TABLE Topic
ADD CONSTRAINT t_has_df
    FOREIGN KEY (tdf_id)
    REFERENCES DiscussionForum(df_id);
    
ALTER TABLE Post
ADD CONSTRAINT p_has_t
  FOREIGN KEY (pt_id)
  REFERENCES Topic(t_id)
ADD CONSTRAINT p_has_author
  FOREIGN KEY (author_id)
  REFERENCES Person(person_id);
ADD column Reply NUMBER;
  
ALTER TABLE CourseGrade
ADD CONSTRAINT cg_has_student
      FOREIGN KEY (s_id)
      REFERENCES Student(student_id)
ADD CONSTRAINT cg_has_course
      FOREIGN KEY (c_id)
      REFERENCES Course(c_id);

ALTER TABLE GroupMemberAccount
ADD CONSTRAINT gma_has_person
    FOREIGN KEY(gmap_id)
    REFERENCES Person(person_id)
ADD CONSTRAINT gma_has_group
    FOREIGN KEY (gmag_id)
    REFERENCES GGroup(g_id);

ALTER TABLE Moderator
ADD CONSTRAINT m_is_person
    FOREIGN KEY (m_id)
    REFERENCES Person(person_id)
ADD CONSTRAINT m_has_group
    FOREIGN KEY (mg_id)
    REFERENCES GGroup(g_id)
ADD CONSTRAINT m_has_df
    FOREIGN KEY (mdf_id)
    REFERENCES DiscussionForum(df_id);

ALTER TABLE CourseList
ADD CONSTRAINT entry_has_course
  FOREIGN KEY (c_id)
  REFERENCES Course(c_id)
ADD CONSTRAINT entry_has_student
  FOREIGN KEY (s_id)
  REFERENCES Student(student_id);
