import subprocess

from db.dynamodb.blocklist.list_value_mapping import ListValueMappingItem
from db.dynamodb.blocklist.object_to_list_mapping import ObjectToListMappingItem



p = subprocess.Popen(['okta-awscli', '--profile', 'core', '--okta-profile', 'core'])
print(p.communicate())
object_mapping_item = ObjectToListMappingItem(object_type="campaign")
list_item_1 = object_mapping_item.create_new_target_list(list_type="network", list_values="data.com")
object_mapping_item.write()

list_value_mapping = ListValueMappingItem(list_type="pmp",list_values="PMP001")


# list_type = list_value_mapping.list_type