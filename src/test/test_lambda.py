import unittest
from importlib.util import spec_from_file_location, module_from_spec
spec = spec_from_file_location('lamdba_function',
                               'src/hello-world/lambda_function.py')
lamdba_function = module_from_spec(spec)
spec.loader.exec_module(lamdba_function)


class TestHelloWorld(unittest.TestCase):
    def test_LambdaHandler(self):
        self.assertEqual(lamdba_function.lambda_handler('', ''),
                         {
            'statusCode': 200,
            'headers': {'Content-Type': 'application/json'},
            'body': '{"Hello": "World"}'
        }
        )


if __name__ == '__main__':
    unittest.main()
