USE quanlysinhvien;

-- 1. Hiển thị tất cả các thông tin môn học (bảng subject) có credit lớn nhất
SELECT *
FROM Subject
WHERE Credit = (SELECT MAX(Credit) FROM Subject);

-- 2. Hiển thị các thông tin môn học có điểm thi lớn nhất
SELECT s.SubID, s.SubName, e.Mark
FROM ExamResults e
JOIN Subject s ON e.SubID = s.SubID
WHERE e.Mark = (SELECT MAX(Mark) FROM ExamResults);

-- 3. Hiển thị các thông tin sinh viên và điểm trung bình của mỗi sinh viên, xếp hạng theo thứ tự điểm giảm dần
SELECT s.StudentID, s.StudentName, AVG(e.Mark) AS AvgMark
FROM Student s
JOIN Exam e ON s.StudentID = e.StudentID
GROUP BY s.StudentID, s.StudentName
ORDER BY AvgMark DESC;