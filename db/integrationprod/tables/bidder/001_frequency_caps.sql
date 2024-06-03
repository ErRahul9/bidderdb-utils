-- create type bidder.frequency_cap_object_type as enum ('campaign', 'campaign_group');
--
-- alter type bidder.frequency_cap_object_type owner to qacore;

create table bidder.frequency_caps
(
    object_id              bigint                              not null,
    frequency_cap_id        integer,
    frequency_cap          integer                             not null,
    frequency_cap_duration bigint                              not null,
    active                 boolean   default true,
    create_time timestamp without time zone not null default CURRENT_TIMESTAMP,
    update_time timestamp without time zone,
    object_type            text    not null
);

alter table bidder.frequency_caps
    owner to qacore;

