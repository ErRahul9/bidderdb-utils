import yaml
import os

def parse(path, file_name, env):

    with open(path + file_name, 'r') as file:
        data = yaml.safe_load(file)

    qa_env_variable_yaml = [
        {'name': 'POSTGRES_USER', 'value': 'qacore'},
        {'name': 'POSTGRES_PW', 'value': 'qa#core07#19'},
        {'name': 'POSTGRES_HOST', 'value': 'integration-dev.crvrygavls2u.us-west-2.rds.amazonaws.com'},
        {'name': 'POSTGRES_PORT', 'value': '5432'},
        {'name': 'POSTGRES_DATABASE', 'value': 'qacoredb'},
    ]
    docker_env_variable_yaml = [
        {'name': 'POSTGRES_USER', 'value': 'integrationdb'},
        {'name': 'POSTGRES_PW', 'value': 'password'},
        {'name': 'POSTGRES_HOST', 'value': 'localhost'},
        {'name': 'POSTGRES_PORT', 'value': '5430'},
        {'name': 'POSTGRES_DATABASE', 'value': 'integrationdb'},
    ]
    prod_env_variable_yaml = [
        {'name': 'POSTGRES_USER', 'value': 'steelhousecore'},
        {'name': 'POSTGRES_PW', 'value': 'Sh#242prod#238'},
        {'name': 'POSTGRES_HOST', 'value': 'integration-prod-master.crvrygavls2u.us-west-2.rds.amazonaws.com'},
        {'name': 'POSTGRES_PORT', 'value': '5432'},
        {'name': 'POSTGRES_DATABASE', 'value': 'integrationprod'},
    ]

    for item in data['env']:
        try:

            os.environ[item['name']] = item['value']
            print(f"export {item['name']}=\"{item['value']}\"")
        except:
            continue

    if env == "docker":
        for item in docker_env_variable_yaml:
            print(f"export {item['name']}=\"{item['value']}\"")
            os.environ[item["name"]] = item["value"]

    if env == "qa":
        for item in qa_env_variable_yaml:
            print(f"export {item['name']}=\"{item['value']}\"")
            os.environ[item["name"]] = item["value"]
    if env == "prod":
        for item in prod_env_variable_yaml:
            print(f"export {item['name']}=\"{item['value']}\"")
            os.environ[item["name"]] = item["value"]