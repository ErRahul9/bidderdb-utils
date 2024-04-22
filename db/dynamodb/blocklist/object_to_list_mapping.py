from typing import Dict

from core.db.dynamodb.tables.object_to_list_mapping_dev import ObjectToListMappingDev
from core.helpers.blocklist.list_value_mapping import ListValueMappingItem


class ObjectToListMappingItem:
    """This class represents a single ObjectToListMapping item. It also keeps track of which
    ListValueMapping items are associated with it.
    """

    def __init__(self, object_id: int = None, object_type: str = None) -> None:
        self.object_id: int = object_id
        self.object_type: str = object_type or "campaign"  # campaign or advertiser
        self.target_lists: Dict[str, str] = {}  # {list_id: action}
        self.children: list[ListValueMappingItem] = []
        self._record: ObjectToListMappingDev = None

    def write(self) -> "ObjectToListMappingItem":
        """Write the object's current data set to the ObjectToListMapping dynamodb table. If no
        target lists have been created before this point, a default list will be created and
        associated with this object. Store the db's object_id in this object.

        Args:
            None
        Returns:
            self (:obj:`ObjectToListMappingItem`): Current object.
        """
        if self.target_lists == {}:
            self.create_new_target_list()
        self._record = ObjectToListMappingDev(
            ObjectId=self.object_id, ObjectType=self.object_type, List=self.target_lists
        )
        self._record.create()
        self.object_id = int(self._record.ObjectId)
        return self

    def create_new_target_list(
        self, list_id: int = None, list_type: str = None, list_values=None, action: str = "block"
    ) -> "ListValueMappingItem":
        """Create a new ListValueMappingItem and associate it with this object.

        Args:
            list_id (int, optional): The id for the new list. An unused id will be generated if none is provided.
            list_type (str, optional): The type of the new list. Defaults to 'pmp'.
            list_values (): A string or list of string values. Default will be generated if none is provided.
        Returns:
            target_list (:obj:`ListValueMappingItem`): The newly created ListValueMappingItem object.
        """
        target_list = ListValueMappingItem(list_id=list_id, list_type=list_type, list_values=list_values)
        target_list.write()
        self.children.append(target_list)
        self.target_lists[str(target_list.list_id)] = action
        return target_list

    def add_existing_target_list(self, target_list: ListValueMappingItem, action: str = "block") -> None:
        """Associate an existing ListValueMappingItem to this object. Note that any associated records
        will be deleted with this when this object's delete() function is called.

        Args:
            target_list (:obj:`ListValueMappingItem`): The ListValueMappingItem object to be associated with.
            action (str, optional): Whether this mapping will consider the list a block list or allow
                list. Defaults to block.
        Returns:
            None
        """
        self.target_lists[str(target_list.list_id)] = action
        self.children.append(target_list)
        self.write()

    def delete_target_list(self, target_list: ListValueMappingItem) -> None:
        """Delete a ListValueMappingItem from dynamodb and disassociate it from this object. Update
        this object in dynamo to reflect the deletion.

        Args:
            target_list (:obj:`ListValueMappingItem`): The ListValueMappingItem object to delete and disassociate.
        Returns:
            None
        """
        del self.target_lists[str(target_list.list_id)]
        for item in self.children:
            if item == target_list:
                item.delete()
        self.children.remove(target_list)
        self.write()

    def delete(self) -> None:
        """Delete this object AND any associated list value objects from dynamodb.

        Args:
            None
        Returns:
            None
        """
        for child in self.children:
            child.delete()
        self._record.delete()
