
/* Part A */
  /*A1*/
CREATE TABLE STUDENT_JANET (
  StudentId   NUMBER(9) PRIMARY KEY,
  Lastname    VARCHAR2(20) NOT NULL,
  Firstname   VARCHAR2(20) NOT NULL,
  ProgramCode NUMBER(4),
  Email       VARCHAR2(60)
);

  /*A2*/
INSERT INTO STUDENT_JANET (StudentId, Lastname, Firstname, ProgramCode, Email)
VALUES (300111222, 'Rav', 'Anna', 3409, 'ranna@my.centennialcollege.ca');

  /*A3*/
INSERT ALL
  INTO STUDENT_JANET (StudentId, Lastname, Firstname, ProgramCode, Email)
  VALUES (300123123, 'Chong', 'Raul', 3409, 'rchong@my.centennialcollege.ca')
  INTO STUDENT_JANET (StudentId, Lastname, Firstname, ProgramCode, Email)
  VALUES (300124124, 'Vasudevan', 'Hima', 3408, 'hvasu@my.centennialcollege.ca')
SELECT 1 FROM dual;

  /*A4*/
UPDATE STUDENT_JANET
SET ProgramCode = 3408
WHERE StudentId = 300111222;

  /*A5*/
DELETE FROM STUDENT_JANET
WHERE StudentId = 300123123;

COMMIT;

/*Part B*/
   /*B1*/.
SELECT * FROM PUBLISHER;

   /*B2*/
SELECT Title,
       Pubdate AS "Publication Date",
       Retail
FROM BOOKS;

   /*B3*/
SELECT Firstname || ' ' || Lastname AS "Customer Name",
       City,
       State
FROM CUSTOMERS;

    /*B4*/
SELECT DISTINCT Category
FROM BOOKS;

    /*B5*/
SELECT *
FROM ORDERITEMS
WHERE "Order#" = 1007;
