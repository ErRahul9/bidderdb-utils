from __future__ import annotations

from dataclasses import dataclass, field
from random import randint
from typing import Dict

from db.dynamodb.base import DynamoDbItem


@dataclass(kw_only=True)
class ObjectToListMappingDev(DynamoDbItem):
    _table_name = "ObjectToListMapping-dev"

    ObjectId: str = field(default=None, metadata={"partition_key": True})
    ObjectType: str = field(default="advertiser", metadata={"sort_key": True})  # "advertiser" or "campaign"
    List: Dict[str, str] = field(default_factory=lambda: {"1234": "block"})  # "block" or "allow"

    def create(self) -> None:
        """Create the object in the dynamodb table with the given or self generated partition key."""
        super().create(partition_key_value=self.ObjectId or self._generate_partition_key())

    def _generate_partition_key(self) -> int:
        """Search the table and return a partition key that isn't currently in use."""
        while True:
            generated_value = str(randint(100000, 999999))
            item = self.get_by_keys(partition_key_value=generated_value, sort_key_value=self.ObjectType)
            if item is None:
                break
        return generated_value
