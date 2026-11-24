##======================= session 7 ==============



/*1.
<p>Write a query in `coaching_groupby.sql` that groups `class_marks` by batch and returns batch, papers (COUNT), avg_marks (rounded to 1 decimal) and best_mark (MAX), sorted by avg_marks from
 highest to lowest. The result must have exactly 3 rows. Hint: Every non-aggregated column in SELECT must appear in GROUP BY.</p>*/
 
 use restaurants;
 
 SELECT
    batch,
    COUNT(*) AS papers,
    ROUND(AVG(marks), 1) AS avg_marks,
    MAX(marks) AS best_mark
FROM class_marks
GROUP BY batch
ORDER BY avg_marks DESC
LIMIT 3;
 
 
 
/*2.
<p>Write a query that groups by subject and batch and keeps only the groups with 
avg_marks of at least 60 and at least 3 papers, using HAVING. Add it to `coaching_groupby.sql`
 and add a comment with the number of groups that HAVING removed compared with the unfiltered version.</p>*/
 
 select * from class_marks;
 
 ALTER TABLE class_marks
ADD COLUMN subject VARCHAR(100);
 
 UPDATE class_marks
SET subject = 'Mathematics'
WHERE subject IS NULL;
 
SELECT
    subject,
    batch,
    COUNT(*) AS papers,
    ROUND(AVG(marks), 1) AS avg_marks
FROM class_marks
GROUP BY subject, batch
HAVING AVG(marks) >= 60
   AND COUNT(*) >= 3;
 
 
 
 
/*3.
<p>Write a query on papers taken on or after '2026-09-01' that groups by batch and
 keeps batches with avg_attendance above 70. Use WHERE for the date and HAVING for the average in the same query.
 Add it to `coaching_groupby.sql`. Constraint: Do not put an aggregate function inside WHERE.</p>*/
 
 select * from class_marks;
 
 ALTER TABLE class_marks
ADD COLUMN attendance DECIMAL(5,2);

ALTER TABLE class_marks
ADD COLUMN paper_date DATE;

UPDATE class_marks
SET attendance = 85
WHERE attendance IS NULL;

UPDATE class_marks
SET paper_date = '2026-09-15'
WHERE paper_date IS NULL;
 
 
 SELECT
    batch,
    COUNT(*) AS papers,
    ROUND(AVG(attendance), 1) AS avg_attendance
FROM class_marks
WHERE paper_date >= '2026-09-01'
GROUP BY batch
HAVING AVG(attendance) > 70;
 
 
 
/*4.
<p>Finish `coaching_groupby.sql` with a toppers query that groups by student_name and 
returns papers, avg_marks and best_mark for students whose avg_marks is at least 70, sorted by avg_marks descending
 with LIMIT 5. Run the whole file and confirm at least 3 students appear.</p>*/
 

SELECT
    student_name,
    COUNT(*) AS papers,
    ROUND(AVG(marks), 1) AS avg_marks,
    MAX(marks) AS best_mark
FROM class_marks
GROUP BY student_name
HAVING AVG(marks) >= 70
ORDER BY avg_marks DESC
LIMIT 5;
