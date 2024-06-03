from db.dynamodb.tables.list_value_mapping_dev import ListValueMappingDev


class ListValueMappingItem:
    def __init__(self, list_id: int = None, list_type: str = None, list_values=None) -> None:
        self.list_id: int = list_id
        self.list_type: str = list_type or "pmp"
        self.list_values = list_values or []
        self._record: ListValueMappingDev = None

    def write(self) -> "ListValueMappingItem":
        """Write the object's current data set to the ListValueMapping dynamodb table. Store
        the db's list_id in this object.

        Args:
            None
        Returns:
            self (:obj:`ListValueMappingItem`): Current object.
        """
        self.list_values = ["test-automation.com"] if self.list_values == [] else self.list_values
        self.list_values = [self.list_values] if isinstance(self.list_values, str) else self.list_values
        self._record = ListValueMappingDev(
            ListId=self.list_id, ListType=self.list_type, ListValue=set(self.list_values)
        )
        self._record.create()
        self.list_id = int(self._record.ListId)
        return self

    def add_value(self, value: str) -> None:
        """Add a value to this object's list. Separate write command necessary to reflect in dynamo.

        Args:
            value (str): The value to be added to this object's list.
        Returns:
            None
        """
        self.list_values.append(value)

    def remove_value(self, value: str) -> None:
        """Remove a value from this object's list. Separate write command necessary to reflect in dynamo.

        Args:
            value (str): The value to be removed to this object's list.
        Returns:
            None
        """
        self.list_values.remove(value)

    def delete(self) -> None:
        """Delete this object from the ListValueMapping dynamo table.

        Args:
            None
        Returns:
            None
        """
        self._record.delete()
