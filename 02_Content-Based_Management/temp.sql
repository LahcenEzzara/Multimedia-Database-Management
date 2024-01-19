INSERT INTO Student (code, lname, fname, field, photo)
VALUES (1, 'Lahcen', 'EZZARA', 'IAGI', EMPTY_BLOB());


CREATE OR REPLACE DIRECTORY my_dir2 AS 'C:\Users\Lahcen\Downloads';



GRANT READ, WRITE ON DIRECTORY my_dir TO sys;


DECLARE
  src_loc  BFILE;
  dest_loc BLOB;
BEGIN
    src_loc := BFILENAME('MY_DIR', 'lahcen.jpg');

  SELECT photo INTO dest_loc FROM Student WHERE code = 1 FOR UPDATE;

  DBMS_LOB.LOADFROMFILE(dest_loc, src_loc, DBMS_LOB.GETLENGTH(src_loc));

  COMMIT;
END;
/


DECLARE
  src_loc  BFILE;
  dest_loc BLOB;
BEGIN
  src_loc := BFILENAME('MY_DIR', 'lahcen-new.jpg');

  SELECT photo INTO dest_loc FROM Student WHERE code = 1 FOR UPDATE;

  DBMS_LOB.LOADFROMFILE(dest_loc, src_loc, DBMS_LOB.GETLENGTH(src_loc));

  COMMIT;
END;
/


DELETE FROM Student WHERE code = 1;
