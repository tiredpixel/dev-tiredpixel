#!/bin/sh

cat \
	database/0_init.sql \
	database/1_migrate_*.sql \
	database/2_exec.sql
