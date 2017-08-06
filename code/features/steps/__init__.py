"Behave definitions"

import os
import requests
from behave import given, when, then
from nose.tools import assert_equal

@given('I am using server "{server}"')
def using_server(context, server):
    context.server = os.environ.get(server[1:], '')

@when('I make a GET request to "{uri}"')
def get(context, uri):
    url = ''.join([context.server, uri])
    context.response = requests.get(url)

@when('I make a POST request to "{uri}"')
def post(context, uri):
    url = ''.join([context.server, uri])
    context.response = requests.post(url, data={})

@then('the response status should be {status}')
def response_status(context, status):
    assert_equal(context.response.status_code, int(status))

@then('the response content should be "{content}"')
def response_content(context, content):
    assert_equal(context.response.content.decode('utf-8'), content)
