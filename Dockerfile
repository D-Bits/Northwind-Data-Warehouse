FROM quay.io/astronomer/ap-airflow:2.0.0-buster-onbuild


USER root

COPY . .

# Allow psql to access the .pgpass file
RUN chmod 600 /usr/local/airflow/.pgpass

# Install psql, so pg_restore can be used
RUN apt install postgresql-client

# Make sure Pip is up to date 
RUN pip install --upgrade pip

# Install Python packages
COPY ./requirements.txt ./requirements.txt
