create table dso.frequency_caps
(
    advertiser_id     integer                 not null,
    campaign_group_id integer                 not null,
    campaign_id       integer                 not null
        constraint frequency_caps_pkey1
            primary key,
    cap               integer                 not null,
    duration          integer                 not null,
    transaction_id    uuid                    not null,
    create_time       timestamp default now() not null,
    update_time       timestamp default now() not null
);

alter table dso.frequency_caps
    owner to qacore;
