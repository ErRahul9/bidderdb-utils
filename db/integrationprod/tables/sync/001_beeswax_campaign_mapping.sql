create table sync.beeswax_campaign_mapping
(
    beeswax_campaign_mapping_id integer  not null,
    steelhouse_id               integer
        constraint unique_steelhouse_id_constraint
            unique,
    partner_id                  integer,
    line_item_id                integer,
    targeting_expr_id           integer,
    deal_list_id                integer,
    delivery_mod_id             integer,
    mntn_segment_id             integer
);

alter table sync.beeswax_campaign_mapping
    owner to qacore;
