"""
Create the Northwind OLTP database by restoring 
from the provided .tar file.
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
pg_cred = {
    'db': getenv("POSTGRES_DB"),
    'user': getenv("POSTGRES_USER"),
    'pass': getenv("POSTGRES_PASSWORD"),
    'host': getenv("POSTGRES_HOST")
}

# Open a connection
conn = psycopg2.connect(dbname=pg_cred['db'], user=pg_cred['user'], password=pg_cred['pass'], host=pg_cred['host'], port=5432)

# Allow creation of databases via Python
conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)

# Create a cursor for running queries
cur = conn.cursor()

@dag(default_args=default_args, schedule_interval=None, start_date=None)
def create_northwind():

    # Create an empty db to restore to
    @task()
    def create():

        return cur.execute("CREATE DATABASE northwind;"), cur.commit()


    # Restore the database
    @task()
    def restore(create_task):

        return cur.execute("pg_restore -h localhost northwind < ./sql/northwind.tar;"), cur.commit()


    create_db = create()
    restore(create_db)
    

create_northwind_dag = create_northwind()

