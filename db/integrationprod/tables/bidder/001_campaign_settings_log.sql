CREATE SEQUENCE IF NOT EXISTS bidder.campaign_settings_log_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;


create table bidder.campaign_settings_log (
  id integer primary key not null default nextval('bidder.campaign_settings_log_id_seq'::regclass),
  advertiser_id integer not null,
  campaign_id integer not null,
  message text,
  message_type text,
  created_on timestamp with time zone default CURRENT_TIMESTAMP
);
create index campaign_settings_log_created_on_campaign_id_index on bidder.campaign_settings_log using btree (created_on, campaign_id);
