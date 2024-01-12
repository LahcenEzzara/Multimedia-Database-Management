-- Notes
sqlplus / as sysdba;

SELECT NAME FROM V$DATABASE;


-- Create an instance named ENSAMCASA or just use other instance
-- 


CREATE TABLE Student (
  code NUMBER(10) PRIMARY KEY,
  lname VARCHAR2(50) NOT NULL,
  fname VARCHAR2(50) NOT NULL,
  field VARCHAR2(100),
  photo BFILE
);


CREATE DIRECTORY student_photo AS 'C:/server/student_photo';


INSERT INTO Student (code, lname, fname, field, photo)
VALUES (1, 'EZZARA', 'Lahcen', 'IAGI', BFILENAME('student_photo', 'lahcen.png'));


SELECT * FROM Student;