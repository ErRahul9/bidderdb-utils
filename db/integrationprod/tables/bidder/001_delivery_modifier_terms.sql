-- drop table if exists   bidder.delivery_modifier_terms;
create table bidder.delivery_modifier_terms
(
    delivery_modifier_term_id serial primary key,
    delivery_modifier_id      integer,
    rank                      integer           not null,
    active                    boolean           not null,
    budget_micro_usd          bigint,
    weight                    integer default 0 not null,
    dso_weight                integer,
    dso_weight_updated        boolean,
    bid_volume_percentage     real,
    open_market               boolean,
    flight_id                 integer
);

alter table bidder.delivery_modifier_terms
    owner to qacore;
