<p align="left">
  <a href="https://github.com/al-awstest/hw-python-lambda-apigw-tf/actions"><img alt="CI/CD" src="https://github.com/al-awstest/hw-python-lambda-apigw-tf/workflows/Test%20and%20deploy%20to%20AWS/badge.svg" /></a>
</p>

### python3 hello-world
#### in AWS Lambda Function with API Gateway
##### built and deployed with GitHub Actions using Terraform

Unit Tests can be executed with:
```bash
python3 -m unittest discover src/test
```
Lambda Function can be tested locally with:
```bash
pip3 install python-lambda-local
python-lambda-local -f lambda_handler src/hello-world/lambda_function.py src/test/event.json
```
