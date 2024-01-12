sqlplus / as sysdba;

SELECT NAME FROM V$DATABASE;

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

DECLARE
   src_lob  BFILE := NULL;
   dest_lob BLOB := NULL;
   buffer   RAW(32767);
   amount   BINARY_INTEGER := 32767;
   position INTEGER := 1;
   len      INTEGER;
BEGIN
   -- Select a LOB locator into a PL/SQL variable:
   SELECT photo INTO src_lob FROM Student WHERE code = 1;

   -- Initialize the destination LOB:
   DBMS_LOB.CREATETEMPORARY(dest_lob, TRUE);

   -- Open the LOBs:
   DBMS_LOB.OPEN(src_lob, DBMS_LOB.LOB_READONLY);
   DBMS_LOB.OPEN(dest_lob, DBMS_LOB.LOB_READWRITE);

   -- Get length of the LOB:
   len := DBMS_LOB.GETLENGTH(src_lob);

   -- Read from the BFILE in chunks into the buffer and write to the BLOB:
   WHILE position < len LOOP
      DBMS_LOB.READ(src_lob, amount, position, buffer);
      DBMS_LOB.WRITEAPPEND(dest_lob, amount, buffer);
      position := position + amount;
   END LOOP;

   -- Close the LOBs:
   DBMS_LOB.CLOSE(src_lob);
   DBMS_LOB.CLOSE(dest_lob);
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('No data found for the given code.');
END;
/




GRANT CREATE ANY DIRECTORY TO sys;
GRANT READ, WRITE ON DIRECTORY student_photo TO sys;


CREATE OR REPLACE FUNCTION get_photo_size(p_code IN NUMBER) RETURN INTEGER IS
   l_bfile BFILE;
   l_length INTEGER;
BEGIN
   SELECT photo INTO l_bfile FROM Student WHERE code = p_code;
   
   DBMS_LOB.OPEN(l_bfile, DBMS_LOB.LOB_READONLY);
   
   /* Get the length of the LOB: */
   l_length := DBMS_LOB.GETLENGTH(l_bfile);
   
   DBMS_LOB.CLOSE(l_bfile);
   
   RETURN l_length;
END;
/


SELECT get_photo_size(1) FROM dual;
