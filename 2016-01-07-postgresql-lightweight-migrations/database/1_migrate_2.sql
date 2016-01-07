CREATE FUNCTION pg_temp.migrate_2() RETURNS boolean AS $$
    INSERT INTO _meta (key, value) VALUES ('tmp-2', 2);
    
    SELECT pg_temp.version(2);
$$ LANGUAGE sql;

SELECT COALESCE(pg_temp.migrate(2), pg_temp.migrate_2()) "migrate_2";
