"""
Create the Northwind OLTP, and OLAP databases.
"""
from airflow.decorators import dag, task
from datetime import datetime
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT
from credentials import oltp_conn, olap_conn


default_args = {
    "owner": "airflow",
    "start_date": datetime(2021, 2, 21),
    "retries": 1,
}


# Allow creation of databases via Python
oltp_conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)

# Create a cursor for running queries on the OLTP database
oltp_cur = oltp_conn.cursor()
# Create a cursor for running queries on the OLAP database
olap_cur = olap_conn.cursor()

@dag(default_args=default_args, schedule_interval=None, start_date=None)
def create_databases():

    # Create an empty db to restore the Northwind OLTP database
    @task()
    def create_oltp():

        return oltp_cur.execute("CREATE DATABASE northwind;")


    # Create an empty db to restore the Northwind OLAP database
    @task()
    def create_olap(oltp_task):

        # Close the connection after creating the OLAP db
        return oltp_cur.execute("CREATE DATABASE northwind_dw;")

    # Create tables for OLAP database
    @task()
    def create_tables(olap_task):

        return olap_cur.execute(open("./sql/tables.sql", "r").read()), oltp_conn.close()


    create_oltp = create_oltp()
    create_olap(create_oltp)
    create_tables(create_olap)


create_northwind_dag = create_databases()
