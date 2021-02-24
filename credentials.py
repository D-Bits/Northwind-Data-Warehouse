"""
Helper file to load Postgres credentials and 
connections from.
"""
from sqlalchemy import create_engine
from os import getenv
import psycopg2


"""
OLTP database configs
"""

# Define credentials for the OLTP Postgres database as a dict
oltp_creds = {
    'db': "northwind",
    'user': getenv("POSTGRES_USER"),
    'pass': getenv("POSTGRES_PASSWORD"),
    'host': getenv("POSTGRES_HOST")
}

# Open a connection to the Northwind database
oltp_conn = psycopg2.connect(
    dbname=oltp_creds['db'], 
    user=oltp_creds['user'], 
    password=oltp_creds['pass'], 
    host=oltp_creds['host'], 
    port=5432
)

# Define a SQL Alchemy engine for the OLTP db
oltp_engine = create_engine(getenv("OLTP_STRING"))

"""
OLAP database configs
"""

# Define credentials for the OLAP Postgres database as a dict
olap_creds = {
    'db': "northwind_dw",
    'user': getenv("POSTGRES_USER"),
    'pass': getenv("POSTGRES_PASSWORD"),
    'host': getenv("POSTGRES_HOST")
}

# Open a connection to northwind_dw database
olap_conn = psycopg2.connect(
    dbname=olap_creds['db'], 
    user=olap_creds['user'], 
    password=olap_creds['pass'], 
    host=olap_creds['host'], 
    port=5432
)

# Define a SQL Alchemy engine for the OLAP db
olap_engine = create_engine(getenv("OLAP_STRING"))
