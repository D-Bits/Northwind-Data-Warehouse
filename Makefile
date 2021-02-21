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

# Restart dev environment
restart:
	sudo astro dev stop
	sudo astro dev start

# Deploy to Astronomer Cloud
deploy:
	sudo astro dev deploy
	