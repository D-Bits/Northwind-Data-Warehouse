"""
Simple DAG to create tables in the data warehouse.
"""
from airflow import DAG
from airflow.providers.postgres.operators.postgres import PostgresOperator
from airflow.operators.bash import BashOperator
from datetime import datetime


default_args = {
    "owner": "airflow",
    "start_date": datetime(2021, 3, 3),
    "retries": 1,
}

dag = DAG(
    "build_dbs", 
    schedule_interval=None, 
    template_searchpath=['/usr/local/airflow/dags/sql'], 
    catchup=False, 
    default_args=default_args
)

with dag:

    # Create tables for OLAP db
    t1 = PostgresOperator(
        task_id="create_tables", 
        sql="tables.sql", 
        database="northwind_dw", 
        postgres_conn_id="pg_conn", 
        autocommit=True
    )

    t1 
