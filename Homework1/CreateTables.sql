/*Kevin Brewton, Database Organization Spring 2016*/
CREATE TABLE RecCenterMember(
id number NOT NULL PRIMARY KEY, 
f_name varchar(255) NOT NULL, 
l_name varchar(255) NOT NULL, 
dob date NOT NULL,
family_id number,
CONSTRAINT fk_Rec_family FOREIGN KEY (family_id) REFERENCES Family_Package(id)
);


CREATE TABLE Class(
id number NOT NULL PRIMARY KEY,
title varchar(255) NOT NULL,
type varchar(255) NOT NULL,
CONSTRAINT fk_Class_type FOREIGN KEY (type) REFERENCES Type(type),
instructor number NOT NULL,
CONSTRAINT fk_Class_instructor FOREIGN KEY (instructor) REFERENCES Instructor(id),
season varchar(10) NOT NULL CHECK (season IN ('Spring', 'Summer', 'Fall', 'Winter')),
year number NOT NULL
);

CREATE TABLE Instructor(
id number NOT NULL PRIMARY KEY, 
f_name varchar(255) NOT NULL, 
l_name varchar(255) NOT NULL, 
member_id number,
CONSTRAINT fk_Instructor_member FOREIGN KEY (member_id) REFERENCES RecCenterMember(id)
);

CREATE TABLE Type(
type varchar(255) NOT NULL PRIMARY KEY,
description varchar(255) NOT NULL
);

CREATE TABLE Family_Package(
id number NOT NULL PRIMARY KEY,
address varchar(255) NOT NULL, 
phone varchar(12) NOT NULL,
CONSTRAINT ck_Family_Package UNIQUE (phone)
);

CREATE TABLE Enrollment(
class_id number NOT NULL,
member_id number NOT NULL,
cost number NOT NULL,
CONSTRAINT pk_Enrollment PRIMARY KEY (class_id,member_id),
CONSTRAINT fk_Enrollment_class FOREIGN KEY (class_id) REFERENCES Class(id),
CONSTRAINT fk_Enrollment_member FOREIGN KEY (member_id) REFERENCES RecCenterMember(id)
);