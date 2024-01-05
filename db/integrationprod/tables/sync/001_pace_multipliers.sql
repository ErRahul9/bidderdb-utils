create table sync.pace_multipliers
(
    campaign_id       integer                 not null
        primary key,
    campaign_group_id integer                 not null,
    advertiser_id     integer                 not null,
    pace_multiplier   numeric(16, 2)          not null,
    transaction_id    uuid                    not null,
    create_time       timestamp default now() not null,
    update_time       timestamp default now() not null
);

alter table sync.pace_multipliers
    owner to qacore;
