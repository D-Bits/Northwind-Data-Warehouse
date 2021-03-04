#! /bin/bash

cd /usr/local/airflow/dags/sql/

# Restore Northwind db from backup
pg_restore --username=postgres --host=postgres --file=northwind.tar --no-password