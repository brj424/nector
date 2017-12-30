# ===========================================================================
# Usage: $ make [run|demo|quick|no-venv]
# Prerequisites
#  hosts.xml, openports.xml, vulnlist.csv, events.csv exist with data.
# Post-conditions
#  Performs migrations, imports data from above files to db.sqlite3, then runs
#  the NECTOR server.
# ===========================================================================

all : run quick quick-no-venv demo

.PHONY : all


run :
	python scripts/update-secret-key.py
	python manage.py makemigrations
	python manage.py migrate
	python import-data.py
	python manage.py runserver


quick :
	python scripts/update-secret-key.py
	pip install -r requirements.txt
	python manage.py makemigrations
	python manage.py migrate
	./update-database.sh
	./install-phantomjs.sh
	python manage.py runserver


quick-no-venv :
	python scripts/update-secret-key.py
	sudo pip install -r requirements.txt
	python manage.py makemigrations
	python manage.py migrate
	./update-database.sh
	./install-phantomjs.sh
	python manage.py runserver


demo :
	cp -i sample-data/sample-hosts.xml hosts.xml
	cp -i sample-data/sample-vulnlist.csv vulnlist.csv
	cp -i sample-data/sample-events.csv events.csv
	cp -i sample-data/sample-openports.xml openports.xml
	cp -i sample-data/sample-malware.csv malware.csv
	python scripts/update-secret-key.py
	python manage.py makemigrations
	python manage.py migrate
	python import-data.py
	python manage.py runserver
