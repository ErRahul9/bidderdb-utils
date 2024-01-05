create table sync.beeswax_creative_x_size
(
    sh_creative_id     integer not null
        primary key,
    campaign_x_size_id text    not null
);

alter table sync.beeswax_creative_x_size
    owner to qacore;
