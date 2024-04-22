from __future__ import annotations

from dataclasses import dataclass, field
from random import randint

from core.date_utils import epoch_in_microseconds
from core.db.dynamodb.base import DynamoDbItem


@dataclass(kw_only=True)
class RtbBeeswaxSpendRecordsQa(DynamoDbItem):
    _table_name = "rtb-beeswax-spend-records-dev"

    RequestId: str = field(default=None, metadata={"partition_key": True})
    CampaignGroupId: int = field(default=22222)
    CampaignId: int = field(default=123456)
    CreationTime: int = field(default=epoch_in_microseconds())
    ExpirationTime: int = field(default=epoch_in_microseconds(days=7))
    SpendMicros: int = field(default=16000)
    Timestamp: int = field(default=epoch_in_microseconds())

    def create(self) -> None:
        """Create the object in the dynamodb table with the given or self generated partition key."""
        super().create(self.RequestId or self._generate_partition_key())

    def _generate_partition_key(self) -> int:
        """Search the table and return a partition key that isn't currently in use."""
        while True:
            generated_value = randint(100, 999)
            item = self.get_by_keys(str(generated_value))
            if item is None:
                break
        return generated_value
