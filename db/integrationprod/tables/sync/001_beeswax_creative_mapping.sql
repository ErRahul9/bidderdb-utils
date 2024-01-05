create table sync.beeswax_creative_mapping
(
    beeswax_creative_mapping_id integer  not null,
    steelhouse_id               text,
    partner_id                  integer,
    creative_line_item_id       integer
);

alter table sync.beeswax_creative_mapping
    owner to qacore;
