drop table if exists bidder.delivery_target_list_items;

create table bidder.delivery_target_list_items
(
    delivery_target_list_item_id serial not null,
    delivery_target_list_id      integer not null,
    item                         text    not null
);

alter table bidder.delivery_target_list_items
    owner to qacore;

