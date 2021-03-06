#! /bin/bash

# Restore Northwind db from backup
echo "---Restoring Northwind OLTP database---"
pg_restore --verbose --host=localhost --port=5432 northwind.tar --clean --format=t --dbname=northwind --user=postgres

echo ""
echo "---Restoring Northwind OLAP database---"
# Restore the Northwind data warehouse from a backup
psql -U postgres -h localhost -d northwind_dw -f northwind_dw.sql
