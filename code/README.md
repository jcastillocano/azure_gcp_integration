Python Hello World
==================

This is a basic HTTP python app with two available endpoints, root and a
surprise. Only accepts GET requests, and relies on Flask to serve.

Requirements
------------

In order to run this app you will need:

 * Python 2.7
 * pip

To install all required libs just follow this steps:

 1. Create a virtualenv `virtualenv .virtualenv`
 2. Enable virtualenv `source .virtualenv/bin/activate`
 3. Install dependencies `pip install -r requirements.txt`

To install test required libs also run: 

 4. Install test dependencies `pip install -r test_requirements.txt`

Execute
-------

If you want to start serving this web app, just enable virtualenv where
you installed all dependencies, and run:

 * `python main.py`

You should see your server started on port 5000

```
$ python main.py
 * Running on http://127.0.0.1:5000/ (Press CTRL+C to quit)
```

Tests
-----

To execute _lint_ tests execute:

 * `pylint --rcfile=./tests/.pylint.cfg main.py tests/hello_tests.py`

Unit tests:

 * `nosetests --with-coverage --cover-package=main tests/hello_tests.py`

Integration tests (you need your server up and running on URI:PORT)

 * Export SERVER=http://URI:PORT
 * Run behave `behave`

There is a wrapper to execute all these steps at once, check it at
*run_tests.sh*

Author
------

Juan Carlos Castillo Cano
