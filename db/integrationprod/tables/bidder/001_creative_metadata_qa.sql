create table bidder.creative_metadata_qa
(
    campaign_id                          integer not null,
    advertiser_id                        integer not null,
    width                                integer not null,
    height                               integer not null,
    duration                             integer,
    partner_creative_id                  text    not null,
    line_item_id                         text    not null,
    recency_threshold                    integer,
    household_score_threshold            integer,
    viewability_score_threshold          integer,
    cpm_threshold                        numeric,
    performance_threshold                integer,
    pace_multiplier                      numeric(16, 2),
    objective_id                         integer not null,
    channel_id                           integer not null,
    name                                 text,
    hourly_budget                        numeric(16, 2),
    hourly_campaign_group_budget         numeric(16, 2),
    device_type_budget_percent           text,
    recency_floor_threshold              integer,
    budget_pace                          numeric,
    campaign_group_id                    integer not null,
    impression_cap                       integer,
    impression_cap_duration              integer,
    campaign_group_hourly_impression_cap integer
);

alter table bidder.creative_metadata_qa
    owner to qacore;

