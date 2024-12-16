USE QuanLySinhVien;

SELECT * 
FROM Student 
WHERE StudentName LIKE 'h%';

SELECT * 
FROM Class 
WHERE MONTH(StartTime) = 12;

SELECT * 
FROM Subject 
WHERE Credit BETWEEN 3 AND 5;

UPDATE Student 
SET ClassID = 2 
WHERE StudentName = 'Hung';

SELECT StudentName, SubName, Mark 
FROM ExamResults 
ORDER BY Mark DESC, StudentName ASC;

