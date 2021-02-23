SHELL := /bin/bash


# Initialize project
init:
	sudo python3 -m venv env
	sudo astro dev start

# Bootstrap servers
start:
	sudo astro dev start

# Shutdown servers
stop:
	sudo astro dev stop

# Restore the Northwind OLTP database
restore:
	sudo docker exec -it northwinddwad7581_postgres_1 psql -U postgres \
	pg_restore --dbname=northwind dags/sql/northwind.tar

# Reset dev environment
reset:
	sudo astro dev kill
	sudo astro dev start

# Restart dev environment
restart:
	sudo astro dev stop
	sudo astro dev start

# Start a psql shell in the postgres container
psql:
	sudo docker exec -it northwinddwad7581_postgres_1 psql -U postgres

# Rebuild virtualenv
rebuild:
	rm env -r
	sudo python3 -m venv env
	source env/bin/activate; \
	pip3 install -r requirements.txt

# Deploy to Astronomer Cloud
deploy:
	sudo astro dev deploy
