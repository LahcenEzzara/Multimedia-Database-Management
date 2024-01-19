sqlplus / as sysdba;

SELECT
  NAME
FROM
  V $ DATABASE;

CREATE TABLE Student (
  code NUMBER(10) PRIMARY KEY,
  lname VARCHAR2(50) NOT NULL,
  fname VARCHAR2(50) NOT NULL,
  field VARCHAR2(100),
  photo BLOB
);



INSERT INTO
  Student (code, lname, fname, field, photo)
VALUES
  (
    1,
    'EZZARA',
    'Lahcen',
    'IAGI',
    BFILENAME('student_photo', 'lahcen.png')
  );

SELECT
  *
FROM
  Student;