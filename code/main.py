"""
Hello World for Azure Web App

This app is based on https://docs.microsoft.com/en-us/azure/
app-service-web/app-service-web-get-started-python tutorial
"""

from flask import Flask

app = Flask(__name__)

@app.route('/', methods=['GET'])
def hello():
    "Basic hello world call"
    return 'Hello, World!'

@app.route('/secret', methods=['GET'])
def secret():
    "Secret uri for curious people"
    return 'You won the bounty!'

if __name__ == '__main__':
    app.run()
