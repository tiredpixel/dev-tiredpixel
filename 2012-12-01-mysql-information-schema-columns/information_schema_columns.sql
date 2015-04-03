-- Uses MySQL information_schema to generate comma-separated list of column
-- names, such as can be used to rewrite
--
--     INSERT INTO EG_TABLE VALUES ('a', 'b', 'c');
-- 
-- to use explicit column names
--
--     INSERT INTO EG_TABLE (headerA, headerB, headerC) VALUES ('a', 'b', 'c');
--
SELECT
    GROUP_CONCAT(column_name)
FROM
    information_schema.columns
WHERE
    table_schema = 'EG_DATABASE'
    AND
    table_name = 'EG_TABLE'
    AND
    column_name NOT IN ('EG_COLUMN1', 'EG_COLUMN2')
ORDER BY
    ordinal_position
;