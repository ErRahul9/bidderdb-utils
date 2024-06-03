
drop table if exists bidder.delivery_target_lists;

create table bidder.delivery_target_lists
(
    delivery_target_list_id serial not null,
    name                    text                 not null,
    list_type               text                 not null,
    active                  boolean default true not null
);

alter table  bidder.delivery_target_lists
    owner to qacore;
