BEGIN;
    SELECT
        pg_temp.version() "version_f",
        COALESCE(pg_temp.migrate(1), pg_temp.migrate_1()) "migrate_1",
        COALESCE(pg_temp.migrate(2), pg_temp.migrate_2()) "migrate_2",
        pg_temp.version() "version_t"
    ;
COMMIT;
