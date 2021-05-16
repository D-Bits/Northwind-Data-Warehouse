FROM quay.io/astronomer/ap-airflow:2.0.0-buster-onbuild


USER root

COPY . .

# Make sure Pip is up to date 
RUN pip install --upgrade pip

# Install Python packages
COPY ./requirements.txt ./requirements.txt
