CREATE SEQUENCE IF NOT EXISTS bidder.campaign_budget_by_device_log_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

create table bidder.campaign_budget_by_device_log (
  id integer not null default nextval('bidder.campaign_budget_by_device_log_seq'::regclass),
  advertiser_id integer not null,
  campaign_id integer not null,
  device_type_groups json,
  create_time timestamp without time zone default CURRENT_TIMESTAMP,
  action text not null
);
create index idx_campaign_id on bidder.campaign_budget_by_device_log using btree (campaign_id);
