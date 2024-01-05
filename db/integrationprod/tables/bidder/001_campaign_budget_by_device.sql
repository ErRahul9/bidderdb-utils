CREATE SEQUENCE IF NOT EXISTS bidder.campaign_budget_by_device_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

create table bidder.campaign_budget_by_device (
  id integer not null default nextval('bidder.campaign_budget_by_device_seq'::regclass),
  advertiser_id integer not null,
  campaign_id integer not null,
  device_type_groups json,
  create_time timestamp without time zone default CURRENT_TIMESTAMP,
  update_time timestamp without time zone
);
create unique index uniq_campaign_id on bidder.campaign_budget_by_device using btree (campaign_id);
