SRC_DIR=.
BRANCH=develop

all: clean clone install test build run

test:
	pylint --rcfile=$(SRC_DIR)/tests/.pylint.cfg main.py tests/hello_tests.py --output-format=parseable --reports=y > pylint.log ||:
	nosetests --with-coverage --with-xunit --cover-xml --cover-html --cover-package=main $(SRC_DIR)/tests/hello_tests.py ||:

build:
	rm -f $(SRC_DIR).code.tgz
	tar cvfz $(SRC_DIR)/code.tgz main.py virtualenv_proxy.py web.2.7.config

install:
	virtualenv $(SRC_DIR)/.virtualenv
	. $(SRC_DIR)/.virtualenv/bin/activate
	pip install -r $(SRC_DIR)/requirements.txt

run: clone install
	test ! -e $(SRC_DIR)/.pid
	. $(SRC_DIR)/.virtualenv/bin/activate
	python $(SRC_DIR)/main.py & echo $$! > .pid

clone:
	git pull origin $(BRANCH)

clean:
	rm -f pylint.log
	rm -f nosetests.xml
	rm -f coverage.xml
	rm -f .coverage
	rm -rf cover
	rm -rf reports
	test -e $(SRC_DIR)/.pid && kill `cat .pid` && rm -f .pid ||:

help:
		@echo "make help"
		@echo " * clean: remove tests results, old artifacts and stop any server"
		@echo " * build: tar python scripts as artifact"
		@echo " * clone: pull origin BRANCH"
		@echo " * run: enable virtualenv and run flask app on http://localhost:5000/"
		@echo " * test: run lint and unit tests"
		@echo " * install: install requirements"
