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

# Define a SQL Alchemy engine for the OLTP db
oltp_engine = create_engine(getenv("OLTP_STRING"))


# Define a SQL Alchemy engine for the OLAP db
olap_engine = create_engine(getenv("OLAP_STRING"))
