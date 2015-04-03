-- Thanks be to http://dba.stackexchange.com/a/4130 .

SELECT
  CONCAT("ALTER DEFINER=`USER`@`%` VIEW ", table_name, " AS ", view_definition, ";") 
FROM
  information_schema.views
WHERE
  table_schema='TABLE'
