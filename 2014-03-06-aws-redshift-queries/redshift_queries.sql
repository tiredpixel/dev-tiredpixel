-- = Table Block Sizes (1 block = 1 MB)
-- http://docs.aws.amazon.com/redshift/latest/dg/c_managing_disk_space.html

SELECT
  *
FROM
(
  SELECT
    TP.name "table",
    COUNT(*) "blocks"
  FROM
    stv_blocklist B
    LEFT JOIN
      stv_tbl_perm TP
      ON
        B.tbl = TP.id
  GROUP BY
    TP.name
)
ORDER BY
  blocks DESC
;


-- = Table Vacuums
-- http://docs.aws.amazon.com/redshift/latest/dg/r_STL_VACUUM.html

SELECT
  *
FROM
(
  SELECT
    V.eventtime,
    TP.name "table",
    V.xid,
    V.table_id,
    V.status,
    V.rows,
    V.sortedrows,
    V.blocks
  FROM
    stl_vacuum V
    LEFT JOIN
      stv_tbl_perm TP
      ON
        V.table_id = TP.id
)
ORDER BY
  "eventtime" DESC,
  "table"
;