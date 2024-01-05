create table sync.beeswax_segment_mapping
(
    beeswax_segment_mapping_id serial
        primary key,
    steelhouse_id              text,
    beeswax_segment_key        text,
    partner_id                 integer
);

alter table sync.beeswax_segment_mapping
    owner to qacore;
