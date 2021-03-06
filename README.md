
# About

A data warehouse for the well-known Northwind OLTP database. Built with Apache Airflow and PostgreSQL.

## Local Setup

- First, you will need to install the [Astronomer CLI](https://www.astronomer.io/docs/cloud/stable/develop/cli-quickstart) on your machine.

- You will also need Docker (including Docker Compose) installed before you begin.

- Next, create a `.env` file in the project root, and add the following environment variables:
    ```
    AIRFLOW__CORE__FERNET_KEY=(a Fernet key you have generated)
    LOAD_EX=n
    EXECUTOR=LocalExecutor
    POSTGRES_HOST=postgres
    POSTGRES_USER=postgres 
    POSTGRES_PASSWORD=(your password for the db)
    POSTGRES_DB=postgres
    OLTP_STRING=(SQL Alchemy string for the OLTP Northwind database)
    OLAP_STRING=(SQL Alchemy string for the OLAP Northwind data warehouse)
    ```

- Once you have both of those installed, simply run `sudo astro dev start` from the project root directory to boostrap the Docker containers.
- After the containers have bootstraped, login to the Postgres server with a client of your choice, and create two databases: `northwind`, and `northwind_dw`. Then, run `sh restore.sh`, enter the password you used for the `POSTGRES_PASSWORD` environment variable in the `.env` file.  
- Then, navigate to [localhost:8080](localhost:8080) in your browser.


## DAG Guide


