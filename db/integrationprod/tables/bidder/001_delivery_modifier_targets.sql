-- drop table if exists bidder.delivery_modifier_targets;

create table bidder.delivery_modifier_targets
(
    delivery_modifier_term_id integer not null,
    delivery_target_list_id   integer not null,
    active                    boolean not null
);

alter table bidder.delivery_modifier_targets
    owner to qacore;

