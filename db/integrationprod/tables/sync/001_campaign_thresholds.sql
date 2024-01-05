create table sync.campaign_thresholds
(
    campaign_id                 integer                 not null
        constraint campaign_thresholds_pkey1
            primary key,
    recency_threshold           integer,
    household_score_threshold   integer,
    viewability_score_threshold integer,
    update_time                 timestamp default now() not null,
    cpm_threshold               numeric,
    performance_threshold       integer,
    network_threshold           integer,
    recency_floor_threshold     integer,
    budget_pace                 numeric   default 1.7
);

alter table sync.campaign_thresholds
    owner to qacore;
