"""
Create the Northwind OLTP, and OLAP databases.
"""
from os import getenv
from airflow.decorators import dag, task
from datetime import datetime
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT
import psycopg2


default_args = {
    "owner": "airflow",
    "start_date": datetime(2021, 2, 21),
    "retries": 1,
}

# Define credentials for Postgres database as a dict
pg_creds = {
    'db': getenv("POSTGRES_DB"),
    'user': getenv("POSTGRES_USER"),
    'pass': getenv("POSTGRES_PASSWORD"),
    'host': getenv("POSTGRES_HOST")
}

# Open a connection
conn = psycopg2.connect(
    dbname=pg_creds['db'], 
    user=pg_creds['user'], 
    password=pg_creds['pass'], 
    host=pg_creds['host'], 
    port=5432
)

# Allow creation of databases via Python
conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)

# Create a cursor for running queries
cur = conn.cursor()

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
        return cur.execute("CREATE DATABASE northwind_dw;"), conn.close()


    create_oltp = create_oltp()
    create_olap(create_oltp)


create_northwind_dag = create_databases()
