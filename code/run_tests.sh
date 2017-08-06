#!/bin/bash
set -e

# Not sure why we cannot create a virtualenv from a directory named code
# neither install dependencies, so we cd into tests directory
if [[ ! -e '.virtualenv' ]]; then
    virtualenv .virtualenv
fi

source .virtualenv/bin/activate
pip install -r requirements.txt
pip install -r test_requirements.txt

# Return to parent directory

echo "Running unit tests"
nosetests --with-coverage --with-xunit --cover-xml --cover-html --cover-package=main tests/hello_tests.py

echo "Running violations"
pylint --rcfile=./tests/.pylint.cfg main.py tests/hello_tests.py > pylint.log ||:

python main.py &
MAIN_PID=$!

SERVER=http://127.0.0.1:5000 behave

kill $MAIN_PID
