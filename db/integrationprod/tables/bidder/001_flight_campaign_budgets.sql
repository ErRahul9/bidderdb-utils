create table bidder.flight_campaign_budgets
(
    id                       serial not null,
    flight_id                bigint                              not null,
    campaign_id              integer                             not null,
    hourly_budget_cap_micros bigint                              not null,
    flight_budget_cap_micros bigint                              not null,
    hourly_impression_cap    integer,
    flight_impression_cap    integer,
    active                   boolean   default false             not null,
  create_time timestamp without time zone not null default CURRENT_TIMESTAMP,
  update_time timestamp without time zone
);

alter table bidder.flight_campaign_budgets
    owner to qacore;
--
-- create index flight_campaign_budgets_flight_id_index
--     on bidder.flight_campaign_budgets (flight_id);
--
-- create unique index flight_campaign_budgets_flight_id_campaign_id_index
--     on bidder.flight_campaign_budgets (flight_id, campaign_id);
--
-- create index flight_campaign_budgets_campaign_id_index
--     on bidder.flight_campaign_budgets (campaign_id);
--
-- create trigger update_flight_campaign_budgets_update_time
--     before update
--     on bidder.flight_campaign_budgets
--     for each row
-- execute procedure modify_update_time();

