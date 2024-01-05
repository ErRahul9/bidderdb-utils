create table sync.campaign_thresholds_beeswax
(
    campaign_id                 integer                 not null
        constraint campaign_thresholds_pkey
            primary key,
    recency_threshold           integer,
    device_score_threshold      integer,
    viewability_score_threshold integer,
    publisher_score_threshold   integer,
    create_time                 timestamp default now() not null,
    performance_threshold       numeric
);

alter table sync.campaign_thresholds_beeswax
    owner to qacore;
