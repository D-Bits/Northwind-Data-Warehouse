"""
ETL pipeline to seed the order_fact table.
"""
from airflow.decorators import dag, task
from datetime import datetime
from credentials import oltp_engine, olap_engine
import pandas as pd 


default_args = {
    "owner": "airflow",
    "start_date": datetime(2021, 2, 21),
    "schedule_interval": "@daily",
    "retries": 1,
}


@dag(default_args=default_args, start_date=None)
def seed_order_fact():

    # Extract tables from the OLTP db and return a list of dataframes.
    @task()
    def extract() -> list:

        # Load "orders" table into DataFrame
        orders_df = pd.read_sql_table("orders", oltp_engine, index_col="orderid")
        # Load "order_details" table into DataFrame
        details_df = pd.read_sql_table("order_details", oltp_engine, index_col="orderid")
        dfs = [orders_df, details_df]

        return dfs


    # Clean dataframes, and merge them into one df
    @task()
    def transform(df_list: list):

        merged_df = pd.concat(df_list)

        return merged_df

    
    @task()
    def load(cleaned_df: pd.Series):

        cleaned_df.to_sql(
            'fact_orders', 
            olap_engine, 
            index=False, 
            method='multi', 
            if_exists='append',
        )


    
    extract = extract()
    transform = transform(extract)
    load = load(transform)


seed_order_fact = seed_order_fact()
