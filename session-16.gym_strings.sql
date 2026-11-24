##======================= session 16==============



/*1.
<p>Create `member_contacts` in `gym_membership_db` with member_id, full_name and member_code, and insert 12 deliberately messy rows in `gym_strings.sql`, such as full_name ' rEKHA patel ' and member_code ' gym-ahd-0007',
 with mixed case, extra spaces and some codes using '_' instead of '-'. Use invented names only and no real phone numbers.</p>*/
 
 
CREATE DATABASE IF NOT EXISTS gym_membership_db;

USE gym_membership_db;

CREATE TABLE IF NOT EXISTS member_contacts (
    member_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    member_code VARCHAR(50)
);

INSERT INTO member_contacts (member_id, full_name, member_code)
VALUES
(1, ' rEKHA patel ', ' gym-ahd-0007'),
(2, 'ARJUN  SHARMA', 'GYM-AHD-0008'),
(3, '  priya mehta', 'gym_ahd_0009'),
(4, 'RAHUL singh  ', ' Gym-Ahd-0010 '),
(5, ' neha KUMAR ', 'gym_ahd-0011'),
(6, 'VIKRAM joshi', 'GYM-SRT-0012'),
(7, '  anita DESAI  ', 'gym_srt_0013'),
(8, 'KARAN patel', ' Gym-SRT-0014'),
(9, 'pooja  shah ', 'gym-srt_0015'),
(10, ' AMIT verma', 'GYM_SRT_0016'),
(11, 'sneha  rao', ' gym-ahd_0017 '),
(12, 'ROHAN gupta ', 'gym_ahd-0018');

SELECT * FROM member_contacts;

 
/*2.
<p>Write a query in `gym_strings.sql` that returns member_id and `clean_name` built with CONCAT, UPPER, LOWER, LEFT, SUBSTR and TRIM, 
so the first letter is capital and the rest lower case, with no spaces at either end. Check that ' rEKHA patel ' becomes 'Rekha patel'.</p>*/

SELECT
    member_id,
    CONCAT(
        UPPER(LEFT(TRIM(full_name), 1)),
        LOWER(SUBSTR(TRIM(full_name), 2))
    ) AS clean_name
FROM member_contacts;


/*3.
<p>Write a query that returns `clean_code` (TRIM, UPPER and REPLACE so every code reads like GYM-AHD-0007),
 then `branch_code` (the 3 middle letters using SUBSTR) and `serial_no` (the last 4 characters using RIGHT). Add it to `gym_strings.sql`.
 Every row must follow the same format.</p>*/
 
 
SELECT
    TRIM(
        REPLACE(
            UPPER(member_code),
            '_',
            '-'
        )
    ) AS clean_code,

    SUBSTR(
        REPLACE(UPPER(TRIM(member_code)), '_', '-'),
        5,
        3
    ) AS branch_code,

    RIGHT(
        REPLACE(UPPER(TRIM(member_code)), '_', '-'),
        4
    ) AS serial_no
FROM member_contacts;
 
 
/*4.
<p>Finish `gym_strings.sql` with one query returning member_id, clean_name, clean_code, and `label`,
 built with CONCAT as clean_name followed by ' (' and branch_code and ')'.
 Run the whole file and confirm all 12 rows show consistent codes and no leading or trailing spaces.</p>*/
 
 
SELECT
    member_id,

    CONCAT(
        UPPER(LEFT(TRIM(full_name), 1)),
        LOWER(SUBSTR(TRIM(full_name), 2))
    ) AS clean_name,

    REPLACE(
        UPPER(TRIM(member_code)),
        '_',
        '-'
    ) AS clean_code,

    CONCAT(
        CONCAT(
            UPPER(LEFT(TRIM(full_name), 1)),
            LOWER(SUBSTR(TRIM(full_name), 2))
        ),
        ' (',
        SUBSTR(
            REPLACE(UPPER(TRIM(member_code)), '_', '-'),
            5,
            3
        ),
        ')'
    ) AS label

FROM member_contacts;

 
 
 
 
