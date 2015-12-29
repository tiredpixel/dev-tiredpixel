CREATE FUNCTION pg_temp.migrate_1() RETURNS boolean AS $$
    INSERT INTO _meta (key, value) VALUES ('tmp-1', 1);
    
    SELECT pg_temp.version(1);
$$ LANGUAGE sql;
