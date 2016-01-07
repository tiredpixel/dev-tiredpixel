CREATE TABLE IF NOT EXISTS _meta (
    key     VARCHAR     PRIMARY KEY,
    value   VARCHAR
);

INSERT INTO _meta (key, value) VALUES ('version', 0);


CREATE FUNCTION pg_temp.version() RETURNS integer AS $$
    SELECT value::integer FROM _meta WHERE key = 'version';
$$ LANGUAGE sql;

CREATE FUNCTION pg_temp.version(integer) RETURNS boolean AS $$
    UPDATE _meta SET value = $1 WHERE key = 'version';
    SELECT TRUE;
$$ LANGUAGE sql;

CREATE FUNCTION pg_temp.migrate(integer) RETURNS boolean AS $$
    SELECT CASE WHEN pg_temp.version() = $1 - 1 THEN NULL ELSE FALSE END;
$$ LANGUAGE sql;


BEGIN;

SELECT pg_temp.version() "version_f";
