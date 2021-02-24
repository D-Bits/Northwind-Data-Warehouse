"""
Create the Northwind OLTP, and OLAP databases.
"""
from os import getenv
from airflow.decorators import dag, task
from datetime import datetime
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT
from .credentials import oltp_conn
import psycopg2


default_args = {
    "owner": "airflow",
    "start_date": datetime(2021, 2, 21),
    "retries": 1,
}


# Allow creation of databases via Python
oltp_conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)

# Create a cursor for running queries
cur = oltp_conn.cursor()

@dag(default_args=default_args, schedule_interval=None, start_date=None)
def create_databases():

    # Create an empty db to restore the Northwind OLTP database
    @task()
    def create_oltp():

        return cur.execute("CREATE DATABASE northwind;")


    # Create an empty db to restore the Northwind OLAP database
    @task()
    def create_olap(oltp_task):

        # Close the connection after creating the OLAP db
        return cur.execute("CREATE DATABASE northwind_dw;"), oltp_conn.close()


    create_oltp = create_oltp()
    create_olap(create_oltp)


create_northwind_dag = create_databases()
