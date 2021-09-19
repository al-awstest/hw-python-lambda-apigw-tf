### python3 hello-world
#### in AWS Lambda Function with API Gateway
##### built and deployed with GitHub Actions using Terraform

Unit Tests can be executed with:
```bash
python3 -m unittest discover src/test
```
Lambda Function can be tested locally with:
```bash
python3 -m unittest discover src/test
python-lambda-local -f lambda_handler src/hello-world/lambda_function.py src/test/event.json
```
