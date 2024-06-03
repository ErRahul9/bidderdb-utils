# Use the official DynamoDB Local Docker image as base
FROM python:3.9-slim

RUN #apt-get update && apt-get install -y python3 python3-pip

COPY ./db/dynamodb/tables/*.py /db/dynamodb/tables/
COPY ./db/dynamodb/*.py /db/dynamodb/
#./db/dynamodb/tables/list_value_mapping_dev.

RUN pip3 install boto3

# Run the Python script to insert tables when the container starts
CMD ["python", "/db/dynamodb/tables/list_value_mapping_dev.py"]
CMD ["python", "/db/dynamodb/tables/object_to_list_mapping_dev.py"]
#CMD ["python", "/insert_tables.py"]
