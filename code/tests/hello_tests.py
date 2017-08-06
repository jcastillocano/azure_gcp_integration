from main import app
import unittest

class FlaskrTestCase(unittest.TestCase):

    def setUp(self):
        app.testing = True
        self.app = app.test_client()

    def test_get_hello(self):
        "Verify content for root endpoint"
        output = self.app.get('/')
        self.assertEqual(output.data, 'Hello, World!')
        self.assertEqual(output.status_code, 200)

    def test_get_secret(self):
        "Verify content for secret endpoint"
        output = self.app.get('/secret')
        self.assertEqual(output.data, 'You won the bounty!')
        self.assertEqual(output.status_code, 200)

    def test_post_hello(self):
        "POST to root not allowed"
        output = self.app.post('/', data={})
        self.assertEqual(output.status_code, 405)

    def test_post_secret(self):
        "POST to secret not allowed"
        output = self.app.post('/secret', data={})
        self.assertEqual(output.status_code, 405)

    def test_get_wrong_url(self):
        "Get 404 when you try to GET non existing url"
        output = self.app.get('/uri-does-not-exist')
        self.assertEqual(output.status_code, 404)

    def test_post_wrong_url(self):
        "Get 404 when you try to POST non existing url"
        output = self.app.post('/uri-does-not-exist', data={})
        self.assertEqual(output.status_code, 404)

if __name__ == '__main__':
    unittest.main()
