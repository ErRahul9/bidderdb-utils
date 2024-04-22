from dataclasses import dataclass
from decimal import Decimal

import boto3
from boto3.dynamodb.types import TypeDeserializer, TypeSerializer


@dataclass
class DynamoDbTable:
    _client = boto3.client("dynamodb", region_name="us-west-2")
    _partition_key = None
    _sort_key = None
    _table_attrs = None
    _updatable_attrs = None

    def __post_init__(self):
        self._partition_key, self._sort_key, self._table_attrs, self._updatable_attrs = self._parse_attr_types()

    def _parse_attr_types(self):
        """Determine the partition_key, sort_key, and other attributes based on the given table.

        The partition_key and sort_key values are populated based on the metadata of the inherited class' fields.
        These values cannot be changed after the db item is created. Any other attributes are added to a list
        of updatable fields.

        Args:
            None
        Returns:
            partition_key (str): The name of the partition_key field for the given table.
            sort_key (str): The name of the sort_key field for the given table, if applicable.
            all_table_attrs (list): A list of all attributes for the given table.
            updatable_table_attrs (list): A list of only updatable attributes for the given table.
        """
        partition_key = None
        sort_key = None
        all_table_attrs = []
        updatable_table_attrs = []
        for attr_name, attr_value in self.__dataclass_fields__.items():
            all_table_attrs.append(attr_name)
            if attr_value.metadata.get("partition_key", False):
                partition_key = attr_name
            elif attr_value.metadata.get("sort_key", False):
                sort_key = attr_name
            else:
                updatable_table_attrs.append(attr_name)

        return partition_key, sort_key, all_table_attrs, updatable_table_attrs

    def get_all(self):
        """Return all items in the given table.

        Args:
            None
        Returns:
            A dictionary of all items provided by the response.
        """
        response = self._client.scan(TableName=self._table_name)
        return response["Items"]

    def get_item_count(self):
        """Return the number of items in the given table.

        Args:
            None
        Returns:
            An integer of the number of items currently in the given table.
        """
        response = self._client.scan(Select="COUNT")
        return response["Count"]

    def get_by_keys(self, partition_key_value, sort_key_value=None):
        """Retrieve an item from the given table based on key values provided.

        Args:
            partition_key_value (str): The partition_key value to be used in the table query.
            sort_key_value (str, optional): The sort_key value to be used in the table query.
        Returns:
            item (dict): A dictionary representing the matching item found in the table. None if no item was found.
        """
        request = {"TableName": self._table_name, "Key": {str(self._partition_key): {"S": str(partition_key_value)}}}
        if self._sort_key is not None:
            request["Key"][str(self._sort_key)] = {"S": str(sort_key_value)}

        response = self._client.get_item(**request)
        item = None
        if "Item" in response:
            dynamodb_item = response.get("Item")
            item = self._dynamo_obj_to_python_obj(dynamodb_item)
        return item

    def put(self, payload: dict):
        """Create a new item in the given table based on the dictionary payload provided.

        Args:
            payload (dict): A dictionary payload of all table attributes and accompanying values.
        Returns:
            response (int): The http status code from the request.
        """
        serialized_payload = self._python_obj_to_dynamo_obj(payload)
        request = {"TableName": self._table_name, "Item": serialized_payload}

        response = self._client.put_item(**request)
        return response["ResponseMetadata"]["HTTPStatusCode"]

    def update_by_keys(self, payload: dict, partition_key_value, sort_key_value=None):
        """Update an existing item in the given table based on the dictionary payload provided.

        For more info on the extra update expressions, see the docstring for _construct_update_expression.

        Args:
            payload (dict): A dictionary payload of only updatable table attributes and accompanying values.
        Returns:
            response (int): The http status code from the request.
        """
        update_expression, attribute_names, attribute_values = self._construct_update_expression(payload)
        request = {
            "TableName": self._table_name,
            "Key": {f"{self._partition_key}": {"S": partition_key_value}},
            "UpdateExpression": update_expression,
            "ExpressionAttributeNames": attribute_names,
            "ExpressionAttributeValues": attribute_values,
        }

        if self._sort_key is not None:
            request["Key"][self._sort_key] = {"S": sort_key_value}

        response = self._client.update_item(**request)
        return response["ResponseMetadata"]["HTTPStatusCode"]

    def delete_by_keys(self, partition_key_value, sort_key_value=None):
        """Delete an existing item in the given table based on the key values provided.

        Args:
            partition_key_value: The partition_key value to be used in the table query.
            sort_key_value (optional): The sort_key value to be used in the table query.
        Returns:
            response (int): The http status code from the request.
        """
        request = {
            "TableName": self._table_name,
            "Key": {f"{str(self._partition_key)}": {"S": str(partition_key_value)}},
        }
        if self._sort_key is not None:
            request["Key"][str(self._sort_key)] = {"S": str(sort_key_value)}

        response = self._client.delete_item(**request)
        return response["ResponseMetadata"]["HTTPStatusCode"]

    def _dynamo_obj_to_python_obj(self, dynamo_obj: dict) -> dict:
        """Deserialize a dynamodb formatted dictionary to a python formatted dictionary.

        Example dynamodb formatted dictionary:
        {
            'RequestId': {
                'S': '103'
            },
            'Timestamp': {
                'N': '1690322736000000'
            }
        }

        Args:
            dynamo_obj: a dictionary formatted for use with dynamodb.
        Returns:
            deserialized_dict (dict): A dictionary in a traditional python format.
        """
        deserializer = TypeDeserializer()
        deserialized_dict = {k: deserializer.deserialize(v) for k, v in dynamo_obj.items()}
        for key, value in deserialized_dict.items():
            if isinstance(value, Decimal):
                deserialized_dict[key] = float(value) if "." in str(value) else int(value)
        return deserialized_dict

    def _python_obj_to_dynamo_obj(self, python_obj: dict) -> dict:
        """Deserialize a python formatted dictionary to a dynamodb formatted dictionary.

        Args:
            python_obj: A dictionary in a traditional python format.
        Returns:
            A dictionary formatted for use with dynamodb.
        """
        serializer = TypeSerializer()
        return {k: serializer.serialize(v) for k, v in python_obj.items()}

    def _construct_update_expression(self, payload: dict):
        """Generate necessary update variables based on the provided attributes.

        An update request for boto3 requires a lot more information than the other requests. Including:
            UpdateExpression: The actual expression that sets var_name to var_value. These are only name
                placeholders which are defined in the following two objects.
            ExpressionAttributeNames: A dict of var_names and the actual name of the attribute to be updated.
            ExpressionAttributeValues: A dict of var_values and the actual value the attribute will be updated to.

        Args:
            payload (dict): The fields and values that will be included in the update.
        Returns:
            update_expression (str): The actual update expression, using the format of
                `<name_placeholder> = <value_placeholder>` for each attribute being updated.
            expression_attribute_names (dict): A dict of the update names, using the format of
                {<name_placeholder>: <name_value>} for each attribute being updated.
            expression_attribute_values (dict): A dict of the update values, using the format of
                {<value_placeholder>: <update_value>} for each attribute being updated.
        """
        update_expression_parts = []
        expression_attribute_values = {}
        expression_attribute_names = {}

        serializer = TypeSerializer()
        for key, value in payload.items():
            update_expression_parts.append(f"#{key} = :{key}")
            expression_attribute_values[f":{key}"] = serializer.serialize(value)
            expression_attribute_names[f"#{key}"] = key

        update_expression = "SET " + ", ".join(update_expression_parts)
        return update_expression, expression_attribute_names, expression_attribute_values


@dataclass
class DynamoDbItem(DynamoDbTable):
    def create(self, partition_key_value):
        """Create the new item in the given table based on the inherited class' current attributes and values.

        Args:
            partition_key_value: A value provided by the inherited class to be used as the items partition_key.
        Returns:
            None
        """
        setattr(self, self._partition_key, str(partition_key_value))

        all_attrs = {}
        for attr_name, attr_value in vars(self).items():
            if attr_name in self._table_attrs:
                all_attrs[attr_name] = attr_value

        self.put(payload=all_attrs)

    def get(self):
        """Get the item in the dynamodb table for the current object.

        Args:
            None
        Returns:
            response (dict): A dictionary representing the matching item found in the table. None if no item was found.
        """
        response = self.get_by_keys(
            partition_key_value=self._partition_key_value(), sort_key_value=self._sort_key_value()
        )
        if response is not None:
            for key, value in response.items():
                setattr(self, key, value)
        return response

    def delete(self):
        """Delete the item from the dynamodb table for the current object.

        Args:
            None
        Returns:
            response (int): The http status code from the request.
        """
        response = self.delete_by_keys(
            partition_key_value=self._partition_key_value(), sort_key_value=self._sort_key_value()
        )
        return response

    def update(self):
        """Update the item in the dynamodb table using this object's current values.

        Cycle through the updatable attributes for the given table and store them in a dict. Send the data
        to be updated in the given table. Then update this object based on the dynamodb item using the get method.
        Note that a table's partition_key and sort_key cannot be edited after being created. A replacement
        item will need to be created to change those values.

        Args:
            None
        Returns:
            response (int): The http response code from the request.
        """
        updatable_attrs = {}
        for attr_name, attr_value in vars(self).items():
            if attr_name in self._updatable_attrs:
                updatable_attrs[attr_name] = attr_value

        response = self.update_by_keys(
            payload=updatable_attrs,
            partition_key_value=self._partition_key_value(),
            sort_key_value=self._sort_key_value(),
        )
        self.get()
        return response

    def _partition_key_value(self):
        """Return the current value for the given table's partition_key attribute.

        Args:
            None
        Returns:
            The current value for this object's _partition_key
        """
        return getattr(self, self._partition_key)

    def _sort_key_value(self):
        """Return the current value for the given table's sort_key attribute.

        Args:
            None
        Returns:
            The current value for this object's _sort_key, if available.
        """
        if self._sort_key:
            return getattr(self, self._sort_key)
