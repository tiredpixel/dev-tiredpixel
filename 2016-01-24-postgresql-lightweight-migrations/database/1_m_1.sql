CREATE FUNCTION pg_temp.migration() RETURNS boolean AS $$


-- TODO: insert migration SQL


SELECT pg_temp.version(1);
$$ LANGUAGE sql;
SELECT COALESCE(pg_temp.migrate(1), pg_temp.migration()) "m_1";
DROP FUNCTION pg_temp.migration();
