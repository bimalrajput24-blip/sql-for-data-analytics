/*1.
<p>Write a single query in `coaching_aggregates.sql` on `class_marks` that returns total_papers 
(COUNT), total_marks (SUM), avg_marks (AVG rounded to 2 decimals with ROUND), lowest_mark (MIN) and highest_mark (MAX). 
The result must be one row with 5 columns and total_papers must equal 30.</p>*/
drop table class_marks;
CREATE TABLE class_marks (
    student_id INT,
    student_name VARCHAR(50),
    marks INT
);

INSERT INTO class_marks (student_id, student_name, marks) VALUES
(1, 'Amit', 85),
(2, 'Rahul', 76),
(3, 'Priya', 92),
(4, 'Neha', 68),
(5, 'Ravi', 55);

select * from  class_marks;

SELECT
    COUNT(*) AS total_papers,
    SUM(marks) AS total_marks,
    ROUND(AVG(marks), 2) AS avg_marks,
    MIN(marks) AS lowest_mark,
    MAX(marks) AS highest_mark
FROM class_marks;

/*2.
Write a query for the Evening batch only that returns the lowest, highest and
average attendance_pct (average rounded to 1 decimal), and a second query
 that counts how many papers in the whole table scored below 35. Use WHERE with aggregate functions and add both to 
`coaching_aggregates.sql`. Hint: `COUNT(*)` counts rows after WHERE has filtered them.</p>*/

select * from class_marks;

SELECT
    MIN(attendance_pct) AS lowest_attendance,
    MAX(attendance_pct) AS highest_attendance,
    ROUND(AVG(attendance_pct), 1) AS average_attendance
FROM class_marks
WHERE batch = 'Evening';

SELECT
    COUNT(*) AS papers_below_35
FROM class_marks
WHERE marks < 35;


/*3.
<p>Finish `coaching_aggregates.sql` with a query returning `distinction_pct`, 
the percentage of papers with marks of 75 or more, rounded to 2 decimals. Then copy the table into Excel and
 cross-check all your results with SUM, AVERAGE and COUNTIF. Hint: `ROUND(AVG(marks_out_of_100 >= 75) * 100, 2)` works because a true condition counts as 1.</p>*/
 
 SELECT
    ROUND(AVG(marks >= 75) * 100, 2) AS distinction_pct
FROM class_marks;

select * from class_marks;
