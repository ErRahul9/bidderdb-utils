
from __future__ import annotations

from dataclasses import dataclass, field
from random import randint
from typing import Set

from db.dynamodb.base import DynamoDbItem


@dataclass(kw_only=True)
class ListValueMappingDev(DynamoDbItem):
    _table_name = "ListValueMapping-dev"

    ListId: str = field(default=None, metadata={"partition_key": True})
    ListType: str = field(default="pmp", metadata={"sort_key": True})
    """ListType values: 'device_type_group_list', 'pmp', 'network', or 'publisher'"""
    ListValue: Set[str] = field(default_factory=lambda: {"site1.com", "site2.com"})

    def create(self) -> None:
        """Create the object in the dynamodb table with the given or self generated partition key."""
        super().create(partition_key_value=self.ListId or self._generate_partition_key())

    def _generate_partition_key(self) -> int:
        """Search the table and return a partition key that isn't currently in use."""
        while True:
            generated_value = str(randint(100000, 999999))
            item = self.get_by_keys(partition_key_value=generated_value, sort_key_value=self.ListType)
            if item is None:
                break
        return generated_value
