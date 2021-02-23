FROM quay.io/astronomer/ap-airflow:2.0.0-buster-onbuild


# Install Python packages
COPY ./requirements.txt ./requirements.txt
